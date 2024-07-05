import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';

part 'assignments_bloc.freezed.dart';
part 'assignments_event.dart';
part 'assignments_state.dart';

@singleton
class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final EducationService _educationService;

  AssignmentsBloc(
    this._educationService,
  ) : super(const AssignmentsState.initial(AssignmentsStateData())) {
    on<GetLessonQuestions>(_onGetLessonQuestions);
    on<SaveLessonAnswerText>(_onSaveLessonAnswerText);
    on<UpdateLessonAnswerText>(_onUpdateLessonAnswerText);
    on<SaveLessonAnswerOption>(_onSaveLessonAnswerOption);
    on<UpdateLessonAnswerOption>(_onUpdateLessonAnswerOption);
    on<GetAllLessonQuestions>(_onGetAllLessonQuestions);
  }

  FutureOr<void> _onGetAllLessonQuestions(
    GetAllLessonQuestions event,
    Emitter<AssignmentsState> emit,
  ) async {}

  FutureOr<void> _onSaveLessonAnswerOption(
    SaveLessonAnswerOption event,
    Emitter<AssignmentsState> emit,
  ) async {}

  FutureOr<void> _onUpdateLessonAnswerOption(
    UpdateLessonAnswerOption event,
    Emitter<AssignmentsState> emit,
  ) async {}

  FutureOr<void> _onSaveLessonAnswerText(
    SaveLessonAnswerText event,
    Emitter<AssignmentsState> emit,
  ) async {}

  FutureOr<void> _onUpdateLessonAnswerText(
    UpdateLessonAnswerText event,
    Emitter<AssignmentsState> emit,
  ) async {}

  FutureOr<void> _onGetLessonQuestions(
    GetLessonQuestions event,
    Emitter<AssignmentsState> emit,
  ) async {}
}
