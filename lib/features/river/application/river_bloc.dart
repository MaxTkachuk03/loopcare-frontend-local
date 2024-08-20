import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/extensions/either.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_service.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_view_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_animation_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/get_modules_response.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/river_module_item_state_data.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/river_module_state_data.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_stream_shaders.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/get_cross_module_items_response.dart';

part 'river_event.dart';
part 'river_state.dart';
part 'river_bloc.freezed.dart';

@singleton
class RiverBloc extends Bloc<RiverEvent, RiverState> {
  final RiverService _riverService;
  final AppSyncService _syncService;

  RiverBloc(
    this._syncService,
    this._riverService,
  ) : super(const RiverState.initial(RiverStateData())) {
    on<InitRiver>(_onInitRiver);
    on<GetModules>(_onGetModules);
    on<GetActualModule>(_onGetActualModule);
    on<UpdateModuleItem>(_onUpdateModuleItem);
    on<UpdateActiveModuleItemStatus>(_onUpdateActiveModuleItemStatus);
    on<CheckCompletion>(_onCheckCompletion);
    on<CompleteActiveModule>(_onCompleteActiveModule);
    on<SelectModuleItem>(_onSelectModuleItem);
    on<BounceParentItem>(_onBounceParentItem);
    on<CompleteBuddyModuleItem>(_onCompleteBuddyModuleItem);

    _syncService.stream.listen(
      (event) => event.whenOrNull(
        buddyAcceptedInvite: () => add(const RiverEvent.completeBuddyModuleItem()),
        buddyLeft: () => add(const RiverEvent.getActualModule()),
      ),
    );
  }

  FutureOr<void> _onInitRiver(InitRiver event, Emitter<RiverState> emit) async {
    emit(const RiverState.initial(RiverStateData()));
  }

  FutureOr<void> _onGetModules(GetModules event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    await RiverStreamShader.instance.init('shaders/river_stream_shader.glsl');

    final response = await Future.wait([
      _riverService.getModules(),
      _riverService.getDeferredModuleItems()
    ]);

    if (response.any((e) => e.isLeft())) {
      final error = response.firstWhereOrNull((r) => r.onlyLeft != null)?.onlyLeft;
      emit(RiverState.moduleLoadingError(state.data.copyWith(error: error, isLoading: false)));

    } else {
      final responseModels = response.first.onlyRight as GetModulesResponse;
      final responseCrossModuleItems = response.last.onlyRight as GetCrossModuleItemsResponse;

      final models = _insertCrossModuleItems(responseModels.data, responseCrossModuleItems.data);

      emit(
        RiverState.moduleLoaded(
          state.data.copyWith(
            modules: models,
            activeModule: _getActiveModule(models),
            crossModuleItems: responseCrossModuleItems.data,
            isLoading: false,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onGetActualModule(GetActualModule event, Emitter<RiverState> emit) async {
    final activeModule = state.data.activeModule;
    if (activeModule == null) return;

    final response = await Future.wait([
      _riverService.getModuleById(moduleId: activeModule.id),
      _riverService.getDeferredModuleItems(),
    ]);

    if (response.any((e) => e.isLeft())) {
      final error = response.firstWhereOrNull((r) => r.onlyLeft != null)?.onlyLeft;
      emit(RiverState.moduleLoadingError(state.data.copyWith(error: error, isLoading: false)));
    } else {
      final responseModule = response.first.onlyRight as RiverModule;
      final responseCrossModuleItems = response.last.onlyRight as GetCrossModuleItemsResponse;
      final crossModuleItems = responseCrossModuleItems.data;

      var modules = _migrateCrossModuleItems(
        responseModule,
        crossModuleItems,
      );

      modules = _refreshCrossModuleItemsInModules(
        modules,
        crossModuleItems,
      );

      emit(
        RiverState.moduleLoaded(
          state.data.copyWith(
            activeModule: _getActiveModule(modules),
            modules: modules,
            crossModuleItems: crossModuleItems,
            activeModuleItem: null,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onUpdateActiveModuleItemStatus(
    UpdateActiveModuleItemStatus event,
    Emitter<RiverState> emit,
  ) async {
    var moduleItem = state.data.activeModuleItem;
    var module = state.data.activeModule;

    if (moduleItem == null || moduleItem.states.prevItemState.isCompleted || module == null) {
      emit(
        RiverState.moduleItemLoaded(
          state.data.copyWith(
            modules: state.data.modules,
            activeModule: _getActiveModule(state.data.modules),
            activeModuleItem: null,
            isLoading: false,
          ),
        ),
      );

      return;
    }

    add(RiverEvent.updateModuleItemById(moduleId: module.id, moduleItemId: moduleItem.id));
  }

  FutureOr<void> _onUpdateModuleItem(UpdateModuleItem event, Emitter<RiverState> emit) async {
    var module = state.data.modules.firstWhere((m) => m.id == event.moduleId);
    var moduleItem = module.moduleItems.firstWhere((i) => i.id == event.moduleItemId);

    if (moduleItem.states.animationState == RiverModuleItemAnimationState.bounced) {
      moduleItem = moduleItem.copyWith(
        states: moduleItem.states.copyWith(
          animationState: RiverModuleItemAnimationState.idling,
        ),
      );

      module = _updateModuleItem(event.moduleId, moduleItem);

      emit(
        RiverState.moduleItemLoaded(
          state.data.copyWith(
            modules: _updateModule(module),
          ),
        ),
      );
      return;
    }

    if (_noNeedUpdateModuleItemStates(moduleItem)) return;

    if (_needCompleteModuleItemStates(moduleItem)) {
      moduleItem = _getItemWithNewViewItemState(moduleItem);
      module = _updateModuleItem(event.moduleId, moduleItem);

      final modules = _updateModule(module);
      final activeModule = modules.firstWhereOrNull((m) => m.id == state.data.activeModule?.id);

      emit(
        RiverState.moduleItemLoaded(
          state.data.copyWith(
            activeModule: activeModule,
            modules: modules,
          ),
        ),
      );
      return;
    }

    final response = await _riverService.updateModuleItemState(
      moduleId: event.moduleId,
      moduleItemId: event.moduleItemId,
      data: _getUpdatedItemStateDataFromModuleItem(moduleItem),
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
          final modules = _updateModuleAndUnlockModuleItems(event.moduleId, r);
          final activeModule = modules.firstWhere((m) => m.id == event.moduleId);

          emit(
            RiverState.moduleItemLoaded(
              state.data.copyWith(
                modules: modules,
                activeModule: activeModule,
                activeModuleItem: null,
                isLoading: false,
              ),
            ),
          );

          if (state.data.currentPage > 0) {
            add(const RiverEvent.checkCompletion());
          }
        }
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
        final modules = _completeModuleAndUpdateModuleList(r);

        final activeModule = state.data.activeModule;
        final nextModule = activeModule != null && modules.last.id != activeModule.id
            ? modules.elementAt(state.data.currentPage + 1)
            : activeModule;

        emit(
          RiverState.moduleLoaded(
            state.data.copyWith(
              activeModule: nextModule,
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
          state.data.copyWith(
            modules: state.data.modules,
            activeModule: state.data.activeModule,
            activeModuleItem: null,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onBounceParentItem(BounceParentItem event, Emitter<RiverState> emit) async {
    var module = state.data.modules.firstWhere((m) => m.id == event.moduleId);
    var moduleItem = module.moduleItems
        .firstWhereOrNull((i) => i.unlocksItems.contains(event.moduleItemId));

    if (moduleItem == null) return;

    final statuses = moduleItem.states.copyWith(
      animationState: RiverModuleItemAnimationState.bounced,
    );

    moduleItem = moduleItem.copyWith(
      states: statuses,
    );

    module = _updateModuleItem(event.moduleId, moduleItem);

    emit(
      RiverState.moduleItemLoaded(
        state.data.copyWith(
          modules: _updateModule(module),
        ),
      ),
    );
  }

  FutureOr<void> _onCompleteBuddyModuleItem(
    CompleteBuddyModuleItem event,
    Emitter<RiverState> emit,
  ) async {
    final module = state.data.modules
        .firstWhereOrNull((m) => m.moduleItems.any((i) => i.isBuddyCrossModuleItem));

    final moduleItem = module?.moduleItems.firstWhereOrNull((i) => i.isBuddyCrossModuleItem);

    if (module != null && moduleItem != null) {
      add(RiverEvent.updateModuleItemById(moduleId: module.id, moduleItemId: moduleItem.id));
    }
  }

  // METHODS =================================================================>

  bool _noNeedUpdateModuleItemStates(RiverModuleItem moduleItem) =>
      moduleItem.states.itemState == moduleItem.states.prevItemState &&
          !moduleItem.states.itemState.isUnLocked;

  bool _needCompleteModuleItemStates(RiverModuleItem moduleItem) =>
      moduleItem.states.itemState == moduleItem.states.prevItemState &&
          moduleItem.states.itemState.isUnLocked;

  RiverModuleItemStateData _getUpdatedItemStateDataFromModuleItem(RiverModuleItem moduleItem) {
    final prevItemState = moduleItem.states.itemState;
    final itemState = prevItemState.isUnLocked ? null : prevItemState;

    return RiverModuleItemStateData(itemState: itemState, prevItemState: prevItemState);
  }

  RiverModuleItem _getItemWithNewViewItemState(RiverModuleItem moduleItem) {
    final itemState = moduleItem.actions.isNotEmpty
        ? RiverModuleItemState.read
        : RiverModuleItemState.completed;

    final prevItemState = moduleItem.states.prevItemState;

    return moduleItem.copyWith(
      states: RiverModuleItemViewState(
        itemState: itemState,
        prevItemState: prevItemState,
        animationState: RiverModuleItemAnimationState.read,
      ),
    );
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

  List<RiverModule> _updateModuleAndUnlockModuleItems(int moduleId, RiverModuleItem moduleItem) {
    final index = state.data.modules.indexWhere((m) => m.id == moduleId);
    final moduleItems = <RiverModuleItem>[];

    var module = state.data.modules[index];

    for (final item in module.moduleItems) {
      if (item.id == moduleItem.id) {
        moduleItems.add(moduleItem);
      } else if (moduleItem.unlocksItems.contains(item.id)
          && item.states.prevItemState.isLocked
          && moduleItem.states.prevItemState.isReadOrHigher) {
        moduleItems.add(item.copyWith(states: RiverModuleItemViewState.unlock()));
      } else {
        moduleItems.add(item);
      }
    }

    module = module.copyWith(moduleItems: moduleItems);

    return [...state.data.modules].update(index, module);
  }

  List<RiverModule> _addCrossModuleItem(List<RiverModule> list, int id, RiverModuleItem item) => list
        .map((m) => m.id == id ? m.copyWith(moduleItems: [...m.moduleItems, item]) : m)
        .toList();

  List<RiverModule> _insertCrossModuleItems(
    List<RiverModule> list,
    List<RiverModuleItem> crossModuleItems,
  ) {
    var modules = list;

    final activeModule = _getActiveModule(modules);

    final currentModuleIndex = activeModule == null ? 0 : modules.indexOf(activeModule);

    for (final item in crossModuleItems) {
      if (item.states.prevItemState.isCompleted && item.completedInModuleId != null) {
        modules = _addCrossModuleItem(modules, item.completedInModuleId!, item);
        continue;
      }

      if (item.unlocksFeature.isEmpty &&
          item.actions.isEmpty &&
          !crossModuleItems
              .firstWhere((i) => i.unlocksFeature.firstOrNull == UnlockedFeatureType.buddy)
              .states.prevItemState.isCompleted) {
        continue;
      }

      final parentItemIndex = modules.indexWhere((m) => m.id == item.spawnedInModuleId);

      if (currentModuleIndex > parentItemIndex) {
        modules = _addCrossModuleItem(modules, activeModule?.id ?? item.spawnedInModuleId, item);
      } else {
        modules = _addCrossModuleItem(modules, item.spawnedInModuleId, item);
      }
    }

    return modules;
  }

  List<RiverModule> _completeModuleAndUpdateModuleList(
    RiverModule riverModule,
  ) {
    var nextModule = state.data.nextModule;
    var activeModule = state.data.activeModule;

    List<RiverModule> modules = [];
    for (int i = 0; i < state.data.modules.length; i++) {
      final item = state.data.modules[i];
      if (item.id == activeModule?.id) {
        final crossModuleItems =
            activeModule?.moduleItems.where((i) => i.isCompletedCrossModule).toList() ?? [];

        final module = riverModule.copyWith(
          moduleItems: [...riverModule.moduleItems, ...crossModuleItems],
        );

        modules.add(module);
      } else if (item.id == nextModule?.id) {
        final moduleItems = item.moduleItems
            .map((i) => i.isRootItem ? i.copyWith(states: RiverModuleItemViewState.unlock()) : i)
            .toList();

        final crossModuleItems = activeModule?.moduleItems.where((i) => i.isReadCrossModule) ?? [];

        moduleItems.addAll(crossModuleItems);

        nextModule = item.copyWith(
          moduleItems: moduleItems,
          moduleState: RiverModuleState.inProgress,
        );
        modules.add(nextModule);
      } else {
        modules.add(item);
      }
    }

    return modules;
  }

  List<RiverModule> _migrateCrossModuleItems(
    RiverModule actualModule,
    List<RiverModuleItem> crossModuleItems,
  ) {
    if (state.data.activeModule.containCrossModuleItem) {
      final items = state.data.activeModule?.moduleItems
          .where((i) => i.crossModule)
          .map((i) => crossModuleItems.firstWhereOrNull((c) => c.id == i.id) ?? i) ?? [];

      final module = actualModule.copyWith(moduleItems: [...actualModule.moduleItems, ...items]);

      return _updateModule(module);
    } else {
      return _updateModule(actualModule);
    }
  }


  List<RiverModule> _refreshCrossModuleItemsInModules(
    List<RiverModule> list,
    List<RiverModuleItem> crossModuleItems,
  ) {
    var modules = List.of(list);

    final oldBuddyCrossModuleItem = state.data.crossModuleItems
        .firstWhere((i) => i.isBuddyCrossModuleItem);

    final newBuddyCrossModuleItem = crossModuleItems
        .firstWhere((i) => i.isBuddyCrossModuleItem);

    if (oldBuddyCrossModuleItem.states.prevItemState.isCompleted &&
        newBuddyCrossModuleItem.states.itemState.isRead) {
      final updatedModules = <RiverModule>[];

      for (var module in modules) {
        if (module.moduleItems.any((i) => i.isBuddyCrossModuleItem)) {
          module = module.copyWith(
            moduleItems: module.moduleItems
                .where((i) => !i.isBuddyCrossModuleItem && !i.isAdditionalBuddyCrossModuleItem)
                .toList(),
          );
        }

        if (module.id == state.data.activeModule?.id) {
          module = module.copyWith(
            moduleItems: [...module.moduleItems, newBuddyCrossModuleItem],
          );
        }

        updatedModules.add(module);
      }

      modules = updatedModules;
    } else if (oldBuddyCrossModuleItem.states.itemState.isRead &&
        newBuddyCrossModuleItem.states.itemState.isCompleted) {

      final additionalBuddyModuleItems =
          crossModuleItems.where((i) => i.isAdditionalBuddyCrossModuleItem).toList();

      modules = _insertCrossModuleItems(modules, additionalBuddyModuleItems);
    }

    return modules;
  }

  RiverModule? _getActiveModule(List<RiverModule> models) => models.isNotEmpty
      ? models.firstWhere((module) => module.isInProgress, orElse: () => models.last)
      : null;
}
