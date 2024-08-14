import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/features/river/application/dto/river_module_item_state_data.dart';
import 'package:loopcare_frontend/features/river/application/dto/river_module_state_data.dart';
import 'package:loopcare_frontend/features/river/application/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_state.dart';

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
    emit(const RiverState.initial(RiverStateData()));
  }

  FutureOr<void> _onGetModules(GetModules event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final response = await _riverService.getModules();

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        final activeModule = r.data.isNotEmpty
            ? r.data.firstWhere(
                (module) => !module.isCompleted,
                orElse: () => r.data.last,
              )
            : null;

        emit(
          RiverState.moduleLoaded(
            state.data.copyWith(
              modules: r.data,
              activeModule: activeModule,
              isLoading: false,
            ),
          ),
        );
      },
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

  FutureOr<void> _onUpdateActiveModuleItemStatus(
    UpdateActiveModuleItemStatus event,
    Emitter<RiverState> emit,
  ) async {
    final moduleItem = state.data.activeModuleItem;
    var activeModule = state.data.activeModule;

    emit(RiverState.moduleItemLoading(state.data.copyWith(isLoading: true)));

    RiverModuleItemState itemState;
    if (moduleItem == null || moduleItem.isCompleted || activeModule == null) {
      final module = state.data.modules.firstWhere(
        (m) => m.isInProgress,
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
      (r) async {
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

          add(const RiverEvent.checkCompletion());
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
        if (r.isRootItem) {
          add(const RiverEvent.getActualModule());
          return;
        }

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
      },
    );
  }

  FutureOr<void> _onCheckCompletion(CheckCompletion event, Emitter<RiverState> emit) async {
    if (await state.data.activeModule.lookCompletion()) {
      emit(RiverState.moduleCompleted(state.data));
    }
  }

  FutureOr<void> _onCompleteActiveModule(
    CompleteActiveModule event,
    Emitter<RiverState> emit,
  ) async {
    if (state.data.activeModule == null) return;

    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final response = await _riverService.updateModuleState(
      moduleId: state.data.activeModule?.id ?? -1,
      data: const RiverModuleStateData(moduleState: RiverModuleState.completed),
    );

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        var nextModule = state.data.nextModule;

        List<RiverModule> modules = [];
        for (int i = 0; i < state.data.modules.length; i++) {
          final item = state.data.modules[i];
          if (item.id == state.data.activeModule?.id) {
            modules.add(r);
          } else if (item.id == nextModule?.id) {
            final moduleItems = item.moduleItems
                .map((i) => i.isRootItem ? i.copyWith(itemState: RiverModuleItemState.unlocked) : i)
                .toList();

            nextModule = item.copyWith(
              moduleItems: moduleItems,
              moduleState: RiverModuleState.inProgress,
            );
            modules.add(nextModule);
          } else {
            modules.add(item);
          }
        }

        emit(
          RiverState.moduleLoaded(
            state.data.copyWith(
              activeModule: nextModule ?? state.data.activeModule,
              modules: modules,
              isLoading: false,
            ),
          ),
        );
      },
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
    return module.copyWith(
        moduleItems:
            module.moduleItems.map((i) => i.id == moduleItem.id ? moduleItem : i).toList());
  }
}
