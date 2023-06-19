import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/custom_activity_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_difficulty.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_place.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';

part 'physical_programs_bloc.freezed.dart';

part 'physical_programs_event.dart';

part 'physical_programs_state.dart';

@singleton
class PhysicalProgramsBloc extends Bloc<PhysicalProgramsEvent, PhysicalProgramsState> {
  final PhysicalActivitiesService _physicalActivitiesService;

  PhysicalProgramsBloc(this._physicalActivitiesService)
      : super(const PhysicalProgramsState.initial(PhysicalProgramsData())) {
    on<_GetProgramsByPreferences>(_onGetProgramsByPreferences);
    on<_CreateCustomActivity>(_onCreateCustomActivity);
    on<_SetProgramType>(_onSetProgramType);
    on<_SetProgramPlace>(_onSetProgramPlace);
    on<_SetProgramDifficulty>(_onSetProgramDifficulty);
  }

  FutureOr<void> _onGetProgramsByPreferences(
    _GetProgramsByPreferences event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    emit(PhysicalProgramsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _physicalActivitiesService.getProgramsByPreferences(
      programType: state.data.programType.name,
      programPlace: state.data.programPlace.name,
      programDifficulty: state.data.programDifficulty.name,
    );

    response.fold(
      (l) => null,
      (r) => emit(PhysicalProgramsState.programLoaded(state.data.copyWith(programs: r.data))),
    );
  }

  FutureOr<void> _onCreateCustomActivity(
    _CreateCustomActivity event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    await _physicalActivitiesService.createCustomActivity(
      CustomActivityBody(name: event.name),
    );
  }

  FutureOr<void> _onSetProgramType(_SetProgramType event, Emitter<PhysicalProgramsState> emit) {
    emit(PhysicalProgramsState.programFilterSet(state.data.copyWith(programType: event.programType)));
  }

  FutureOr<void> _onSetProgramPlace(_SetProgramPlace event, Emitter<PhysicalProgramsState> emit) {
    emit(PhysicalProgramsState.programFilterSet(state.data.copyWith(programPlace: event.programPlace)));
  }

  FutureOr<void> _onSetProgramDifficulty(_SetProgramDifficulty event, Emitter<PhysicalProgramsState> emit) {
    emit(PhysicalProgramsState.programFilterSet(
        state.data.copyWith(programDifficulty: event.programDifficulty)));
  }
}
