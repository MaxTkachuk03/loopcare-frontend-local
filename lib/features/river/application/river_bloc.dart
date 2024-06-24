import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/features/river/application/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

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
    on<UpdateModule>(_onUpdateModule);
  }

  FutureOr<void> _onGetModules(GetModules event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    final response = await _riverService.getModules();

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(RiverState.moduleLoaded(state.data.copyWith(modules: r.data, isLoading: false))),
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

  FutureOr<void> _onUpdateModule(UpdateModule event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleLoading(state.data.copyWith(isLoading: true)));

    // TODO create instance of RiverModule with data you want to update
    final data = RiverModule(nextModuleUnlocksAt: DateTime.now());

    final response = await _riverService.updateModule(moduleId: event.moduleId, data: data);

    response.fold(
      (l) => emit(RiverState.moduleLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(RiverState.moduleLoaded(
          state.data.copyWith(modules: _updateModule(r), isLoading: false))),
    );
  }

  FutureOr<void> _onUpdateModuleItem(UpdateModuleItem event, Emitter<RiverState> emit) async {
    emit(RiverState.moduleItemLoading(state.data.copyWith(isLoading: true)));

    // TODO create instance of RiverModuleItem with data you want to update
    const data = RiverModuleItem(
      streamType: RiverModuleStreamType.community,
      iconType: RiverIconType.activity,
      featurePlacement: FeaturePlacement.dashboard,
      itemState: RiverModuleItemState.completed,
    );
    final response =
        await _riverService.updateModuleItem(moduleItemId: event.moduleItemId, data: data);

    response.fold(
      (l) =>
          emit(RiverState.moduleItemLoadingError(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(RiverState.moduleItemLoaded(
          state.data.copyWith(modules: _updateModuleItem(event.moduleId, r), isLoading: false))),
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
