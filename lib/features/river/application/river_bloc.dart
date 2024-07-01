import 'dart:async';
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
    on<GetModules>(_onGetModules);
    on<GetModuleById>(_onGetModuleById);
    on<UpdateModuleItem>(_onUpdateModuleItem);
    on<CheckCompletion>(_onCheckCompletion);
    on<CompleteActiveModule>(_onCompleteActiveModule);
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
            activeModule: r.data.firstWhere((module) => !module.isCompleted),
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onGetModuleById(GetModuleById event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final response = await _riverService.getModuleById(moduleId: event.moduleId);

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(RiverState.moduleLoaded(state.data.copyWith(activeModule: r, isLoading: false))),
    );
  }

  FutureOr<void> _onUpdateModuleItem(UpdateModuleItem event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleItemLoading(state.data.copyWith(isLoading: true)));

    // todo: check if required action is exist iteration 2
    final itemState = RiverModuleItemState.completed;

    // final r = state.data
    //     .modules.firstWhere((module) => module.id == event.moduleId)
    //     .moduleItems.firstWhere((item) => item.id == event.moduleItemId)
    //     .copyWith(itemState: itemState);

    final data = RiverModuleItemStateData(itemState: itemState);

    final response = await _riverService.updateModuleItemState(
      moduleId: event.moduleId,
      moduleItemId: event.moduleItemId,
      data: data,
    );

    response.fold(
      (l) => emit(
        RiverState.moduleItemLoadingError(state.data.copyWith(error: l, isLoading: false)),
      ),
      (r) {
        var modules = _updateModuleItem(event.moduleId, r);

        var activeModule = state.data.activeModule?.id == event.moduleId
            ? state.data.activeModule
            : modules.firstWhere((module) => module.id == event.moduleId);

        if (r.unlocksItems.isNotEmpty) {
          final moduleItems = activeModule!.moduleItems;
          final updatedModuleItems = <RiverModuleItem>[];

          for (int i = 0; i < moduleItems.length; i++) {
            final item = moduleItems[i];
            if (r.unlocksItems.contains(item.id) && item.isLocked) {
              updatedModuleItems.add(item.copyWith(itemState: RiverModuleItemState.unlocked));
            } else {
              updatedModuleItems.add(item);
            }
          }

          activeModule = activeModule.copyWith(moduleItems: updatedModuleItems);
        }

        if (r.isRootItem) {
          activeModule = activeModule?.copyWith(
            nextModuleUnlocksAt:
            DateTime.timestamp().add(Duration(seconds: activeModule.nextModuleUnlockDelay)),
          );
        }

        modules = _updateModule(activeModule!);

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
    final activeModule = state.data.activeModule;
    final isActiveModuleNotCompleted = !(activeModule?.isCompleted ?? true);
    final isTimePassed = state.data.currentPage == 0 ||
        (activeModule?.nextModuleUnlocksAt?.isBefore(DateTime.timestamp()) ?? false);
    final isEveryModuleItemsCompleted = activeModule?.moduleItems.every((item) => item.isCompleted) ?? false;

    if (isActiveModuleNotCompleted && isTimePassed && isEveryModuleItemsCompleted) {
      add(const RiverEvent.completeActiveModule());
    }
  }

  FutureOr<void> _onCompleteActiveModule(CompleteActiveModule event, Emitter<RiverState> emit) async {
    final data = state.data.activeModule!.copyWith(isCompleted: true);

    final List<RiverModule> modules = [];
    var activeModule = data;

    for (int i = 0; i < state.data.modules.length; i++) {
      final module = state.data.modules[i];

      if (i == state.data.currentPage) {
        modules.add(data);
      } else if (i == state.data.currentPage + 1) {
        final moduleItems = module.moduleItems
            .map((e) => e.isRootItem ? e.copyWith(itemState: RiverModuleItemState.unlocked) : e)
            .toList();

        activeModule = module.copyWith(moduleItems: moduleItems);
        modules.add(activeModule);
      } else {
        modules.add(module);
      }
    }

    emit(
      RiverState.moduleLoaded(
        state.data.copyWith(
          modules: modules,
          activeModule: activeModule,
          isLoading: false,
        ),
      ),
    );
  }

  List<RiverModule> _updateModule(RiverModule module) {
    final index = state.data.modules.indexWhere((m) => m.id == module.id);
    return [...state.data.modules].update(index, module);
  }

  List<RiverModule> _updateModuleItem(int moduleId, RiverModuleItem moduleItem) {
    return state.data.modules
        .map((m) => m.id == moduleId
            ? m.copyWith(
                moduleItems:
                    m.moduleItems.map((i) => i.id == moduleItem.id ? moduleItem : i).toList())
            : m)
        .toList();
  }
}
