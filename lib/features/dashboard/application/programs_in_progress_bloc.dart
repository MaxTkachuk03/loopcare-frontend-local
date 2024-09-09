import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

part 'programs_in_progress_bloc.freezed.dart';
part 'programs_in_progress_bloc.g.dart';
part 'programs_in_progress_event.dart';
part 'programs_in_progress_state.dart';

@singleton
class ProgramsInProgressBloc
    extends HydratedBloc<ProgramsInProgressEvent, ProgramsInProgressState> {
  ProgramsInProgressBloc() : super(ProgramsInProgressState.initial()) {
    on<SetProgram>(_onSetProgram);
    on<RemoveProgram>(_onDeleteProgram);
    on<RemoveExpiredPrograms>(_onRemoveExpiredPrograms);
  }

  FutureOr<void> _onSetProgram(
    SetProgram event,
    Emitter<ProgramsInProgressState> emit,
  ) {
    final PhysicalProgram activeProgram = PhysicalProgram.programInProgress(
      id: event.program.id,
      name: event.program.name,
      startDate: DateTime.now().toIso8601String(),
    );

    final Map<String, PhysicalProgram> programs = {
      ...state.programs,
      activeProgram.id.toString(): activeProgram
    };

    emit(state.copyWith(programs: programs));
  }

  FutureOr<void> _onDeleteProgram(
    RemoveProgram event,
    Emitter<ProgramsInProgressState> emit,
  ) {
    final Map<String, PhysicalProgram> programs = {...state.programs}..remove(event.id.toString());

    emit(state.copyWith(programs: programs));
  }

  FutureOr<void> _onRemoveExpiredPrograms(
    RemoveExpiredPrograms event,
    Emitter<ProgramsInProgressState> emit,
  ) {
    final Map<String, PhysicalProgram> programs = {
      for (var e in state.programsList) e.id.toString(): e
    };

    emit(state.copyWith(programs: programs));
  }

  @override
  ProgramsInProgressState? fromJson(Map<String, dynamic> json) =>
      ProgramsInProgressState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ProgramsInProgressState state) {
    return state.toJson();
  }
}
