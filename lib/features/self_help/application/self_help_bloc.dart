import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/self_help/domain/prefer_gender_type.dart';

part 'self_help_bloc.freezed.dart';

part 'self_help_bloc.g.dart';

part 'self_help_event.dart';

part 'self_help_state.dart';

part 'self_help_questions.dart';

@singleton
class SelfHelpBloc extends HydratedBloc<SelfHelpEvent, SelfHelpState> {
  final PreferGenderService preferGenderService;


  SelfHelpBloc(this.preferGenderService)
      : super(SelfHelpState.initial()) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion); 
    on<SetUserPreferGender>(_onSetPreferGender);
    on<GetUserPreferGender>(_onGetPreferGender);
    on<SaveUserPreferGender>(_onSaveDiabetesType);

    on<ResetData>(_onResetData);


  }


  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(SelfHelpState.initial());
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<SelfHelpState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    final nextQuestion = currentQuestion.getNextQuestion();

    emit(state.copyWith(currentQuestion: nextQuestion));
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<SelfHelpState> emit,
  ) {
    final isFirstQuestion = state.currentQuestion.index == 0;
    final previousQuestion = state.currentQuestion.getPreviousQuestion();

    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: previousQuestion,
      ));
    }

  }

  FutureOr<void> _onSetPreferGender(
    PreferGenderTypeChanged event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(state.copyWith(
      preferGenderType: event.preferGender,
    ));
  }

    FutureOr<void> _onGetPreferGender(
    GetUserPreferGender event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(state.copyWith(
      preferGenderType: event.preferGender,
    ));
  }

  @override
  SelfHelpState? fromJson(Map<String, dynamic> json) =>
      SelfHelpState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SelfHelpState state) {
    return state.toJson();
  }
}
