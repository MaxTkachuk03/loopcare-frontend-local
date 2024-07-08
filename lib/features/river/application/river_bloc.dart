import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/features/river/application/dto/river_module_item_state_data.dart';
import 'package:loopcare_frontend/features/river/application/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';

part 'river_event.dart';
part 'river_state.dart';
part 'river_bloc.freezed.dart';

@singleton
class RiverBloc extends Bloc<RiverEvent, RiverState> {
  final RiverService _riverService;

  RiverBloc(this._riverService) : super(const RiverState.initial(RiverStateData())) {
    on<InitRiver>(_onInitRiver);
    on<GetModules>(_onGetModules);
    on<GetActualModule>(_onGetActualModule);
    on<UpdateModuleItem>(_onUpdateModuleItem);
    on<UpdateActiveModuleItemStatus>(_onUpdateActiveModuleItemStatus);
    on<CheckCompletion>(_onCheckCompletion);
    on<CompleteActiveModule>(_onCompleteActiveModule);
    on<SelectModuleItem>(_onSelectModuleItem);
  }

  FutureOr<void> _onInitRiver(InitRiver event, Emitter<RiverState> emit) async {
    emit(const RiverState.moduleLoaded(RiverStateData()));
  }

  FutureOr<void> _onGetModules(GetModules event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final response = await _riverService.getModules();

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        RiverState.moduleLoaded(
          state.data.copyWith(
            modules: r.data,
            activeModule: r.data.firstWhere(
              (module) => !module.isCompleted,
              orElse: () => r.data.last,
            ),
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onGetActualModule(GetActualModule event, Emitter<RiverState> emit) async {
    final response = await _riverService.getModuleById(moduleId: state.data.activeModule!.id);

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        RiverState.moduleLoaded(
          RiverStateData(
            activeModule: r,
            modules: _updateModule(r),
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateActiveModuleItemStatus(UpdateActiveModuleItemStatus event, Emitter<RiverState> emit) async {
    final moduleItem = state.data.activeModuleItem;
    var activeModule = state.data.activeModule;

    RiverModuleItemState itemState;
    if (moduleItem == null || moduleItem.isCompleted || activeModule == null) {
      final module = state.data.modules.firstWhere(
        (m) => !m.isCompleted,
        orElse: () => state.data.modules.last,
      );

      emit(
        RiverState.moduleItemLoaded(
          RiverStateData(
            modules: state.data.modules,
            activeModule: module,
            isLoading: false,
          ),
        ),
      );

      return;
    } else {
      // todo: check if required action is exist iteration 2
      itemState = RiverModuleItemState.completed;
    }

    emit(RiverState.moduleItemLoading(state.data.copyWith(isLoading: true)));

    final data = RiverModuleItemStateData(itemState: itemState);

    final response = await _riverService.updateModuleItemState(
      moduleId: activeModule.id,
      moduleItemId: moduleItem.id,
      data: data,
    );

    response.fold(
      (l) => emit(
        RiverState.moduleItemLoadingError(state.data.copyWith(error: l, isLoading: false)),
      ),
      (r) {
        final isRootPassed = r.isRootItem && state.data.activeModule?.nextModuleUnlocksAt == null;

        if (isRootPassed) {
          add(const RiverEvent.getActualModule());
        } else {
          final updatedModuleItems = <RiverModuleItem>[];

          for (int i = 0; i < activeModule!.moduleItems.length; i++) {
            final item = activeModule!.moduleItems[i];
            if (item.id == r.id) {
              updatedModuleItems.add(r);
            } else if (r.unlocksItems.contains(item.id) && item.isLocked) {
              updatedModuleItems.add(item.copyWith(itemState: RiverModuleItemState.unlocked));
            } else {
              updatedModuleItems.add(item);
            }
          }

          activeModule = activeModule!.copyWith(moduleItems: updatedModuleItems);

          var modules = _updateModule(activeModule!);

          emit(
            RiverState.moduleItemLoaded(
              RiverStateData(
                modules: modules,
                activeModule: activeModule,
                isLoading: false,
              ),
            ),
          );

          if (activeModule!.isAllComplete) {
            add(const RiverEvent.completeActiveModule());
          }
        }
      },
    );
  }

  FutureOr<void> _onUpdateModuleItem(UpdateModuleItem event, Emitter<RiverState> emit) async {
    final response = await _riverService.updateModuleItemState(
      moduleId: event.moduleId,
      moduleItemId: event.moduleItemId,
      data: const RiverModuleItemStateData(itemState: RiverModuleItemState.completed),
    );

    response.fold(
      (l) => emit(
        RiverState.moduleItemLoadingError(state.data.copyWith(error: l, isLoading: false)),
      ),
      (r) {
        final activeModule = _updateModuleItem(event.moduleId, r);

        var modules = _updateModule(activeModule);

        emit(
          RiverState.moduleItemLoaded(
            state.data.copyWith(
              modules: modules,
              activeModule: activeModule,
              isLoading: false,
            ),
          ),
        );

        final isAllModuleItemsCompleted = activeModule.moduleItems.every((i) => i.isCompleted);

        if (isAllModuleItemsCompleted) {
          add(const RiverEvent.checkCompletion());
        }
      },
    );
  }

  FutureOr<void> _onCheckCompletion(CheckCompletion event, Emitter<RiverState> emit) async {
    if (_isActiveModuleCompleted) {
      add(const RiverEvent.completeActiveModule());
    }
  }

  FutureOr<void> _onCompleteActiveModule(CompleteActiveModule event, Emitter<RiverState> emit) async {
    final activeModule = state.data.activeModule!.copyWith(
      isCompleted: true,
    );

    emit(
      RiverState.moduleLoaded(
        RiverStateData(
          activeModule: activeModule,
          modules: _updateModule(activeModule),
        ),
      ),
    );

    if (state.data.currentPage + 1 == state.data.modules.length) {
      return;
    }

    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final nextModule = state.data.modules[state.data.currentPage + 1];

    final response = await _riverService.getModuleById(moduleId: nextModule.id);

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        RiverState.moduleLoaded(
          state.data.copyWith(
            activeModule: r,
            modules: _updateModule(r),
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSelectModuleItem(SelectModuleItem event, Emitter<RiverState> emit) async {
    if (event.item != null) {
      emit(
        RiverState.moduleItemSelected(
          state.data.copyWith(
            activeModuleItem: event.item,
          ),
        ),
      );
    } else {
      emit(
        RiverState.moduleLoaded(
          RiverStateData(
            modules: state.data.modules,
            activeModule: state.data.activeModule,
          ),
        ),
      );
    }
  }

  List<RiverModule> _updateModule(RiverModule module) {
    final index = state.data.modules.indexWhere((m) => m.id == module.id);
    return [...state.data.modules].update(index, module);
  }

  RiverModule _updateModuleItem(int moduleId, RiverModuleItem moduleItem) {
    final module = state.data.modules.firstWhere((m) => m.id == moduleId);
    return module.copyWith(moduleItems: module.moduleItems.map((i) => i.id == moduleItem.id ? moduleItem : i).toList());
  }

  bool get _isActiveModuleCompleted {
    final activeModule = state.data.activeModule;
    final isActiveModuleNotCompleted = !(activeModule?.isCompleted ?? true);
    final isTimePassed = state.data.currentPage == 0 ||
        (activeModule?.nextModuleUnlocksAt?.isBefore(DateTime.timestamp()) ?? false);
    final isEveryModuleItemsCompleted = activeModule?.moduleItems.every((item) => item.isCompleted) ?? false;

    return isActiveModuleNotCompleted && isTimePassed && isEveryModuleItemsCompleted;
  }
}
