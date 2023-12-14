import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/custom_activity_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/log_program_body.dart';
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
    on<_Init>(_onInit);
    on<_CreateCustomActivity>(_onCreateCustomActivity);
    on<_SetProgramType>(_onSetProgramType);
    on<_SetCurrentProgram>(_onSetCurrentProgram);
    on<_SetProgramPlace>(_onSetProgramPlace);
    on<_SetProgramDifficulty>(_onSetProgramDifficulty);
    on<_LogAssessment>(_onLogAssessment);
    on<_GetAllPrograms>(_onGetAllPrograms);
  }

  FutureOr<void> _onInit(
    _Init event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    emit(const PhysicalProgramsState.initial(PhysicalProgramsData()));
  }

  FutureOr<void> _onGetAllPrograms(
    _GetAllPrograms event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    emit(PhysicalProgramsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _physicalActivitiesService.getProgramsByPreferences();

    response.fold(
      (l) => emit(PhysicalProgramsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        PhysicalProgramsState.programLoaded(
          state.data.copyWith(
            allPrograms: r.data,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateCustomActivity(
    _CreateCustomActivity event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    emit(PhysicalProgramsState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _physicalActivitiesService.createCustomActivity(
      CustomActivityBody(name: event.name),
    );

    response.fold(
      (l) => emit(PhysicalProgramsState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(PhysicalProgramsState.programUpdated(state.data.copyWith(isLoading: false, error: null))),
    );
  }

  FutureOr<void> _onSetProgramType(_SetProgramType event, Emitter<PhysicalProgramsState> emit) {
    emit(
      PhysicalProgramsState.programLoaded(
        state.data.copyWith(programType: event.programType),
      ),
    );
  }

  FutureOr<void> _onSetProgramPlace(_SetProgramPlace event, Emitter<PhysicalProgramsState> emit) {
    emit(
      PhysicalProgramsState.programLoaded(
        state.data.copyWith(programPlace: event.programPlace),
      ),
    );
  }

  FutureOr<void> _onSetProgramDifficulty(_SetProgramDifficulty event, Emitter<PhysicalProgramsState> emit) {
    emit(
      PhysicalProgramsState.programLoaded(
        state.data.copyWith(programDifficulty: event.programDifficulty),
      ),
    );
  }

  Future<FutureOr<void>> _onLogAssessment(
    _LogAssessment event,
    Emitter<PhysicalProgramsState> emit,
  ) async {
    emit(PhysicalProgramsState.loading(state.data.copyWith(isLoading: true)));

    var programId = state.data.currentProgram?.id;
    if (programId != null) {
      final response = await _physicalActivitiesService.logProgram(
        programId: programId,
        data: LogProgramBody(
          like: event.like,
          physicalProgramId: programId,
          score: event.score,
        ),
      );

      response.fold(
        (error) => emit(PhysicalProgramsState.error(state.data.copyWith(isLoading: false, error: error))),
        (r) => emit(PhysicalProgramsState.programUpdated(state.data.copyWith(isLoading: false))),
      );
    }
  }

  FutureOr<void> _onSetCurrentProgram(
    _SetCurrentProgram event,
    Emitter<PhysicalProgramsState> emit,
  ) {
    emit(
      PhysicalProgramsState.programLoaded(
        state.data.copyWith(
          currentProgram: event.program,
        ),
      ),
    );
  }
}
