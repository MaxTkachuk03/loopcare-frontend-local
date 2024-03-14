import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_questions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/buddy/domain/request_buddy.dart';
import 'package:loopcare_frontend/features/buddy/infrastrucure/buddy_service.dart';

import 'buddy_status.dart';

part 'buddy_bloc.freezed.dart';
part 'buddy_event.dart';
part 'buddy_state.dart';

@singleton
class BuddyBloc extends Bloc<BuddyEvent, BuddyState> {
  final AuthenticationService _authenticationService;
  final BuddyService _buddyService;

  BuddyBloc(this._authenticationService, this._buddyService) : super(const BuddyState.initial(BuddyStateData())) {
    on<InitBuddy>(_onInitBuddy);
    on<BuddyNextQuestion>(_onBuddyNextQuestion);
    on<BuddyPreviuosQuestion>(_onBuddyPreviousQuestion);
    on<BuddyLiveTogether>(_onBuddyLiveTogether);
    on<BuddyRelation>(_onBuddyRelation);
    on<BuddyEmail>(_onBuddyEmail);
    on<InviteBuddy>(_onInviteBuddy);
    on<GetBuddy>(_onGetBuddy);
    on<RemoveBuddy>(_onRemoveBuddy);
    on<ResendInvitation>(_onResendInvitation);
    on<GetStatusBuddy>(_onGetStatusBuddy);
  }

  FutureOr<void> _onInitBuddy(
    InitBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(const BuddyState.initial(BuddyStateData()));
  }

  FutureOr<void> _onGetStatusBuddy(
    GetStatusBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    final response = await _authenticationService.fetchAccount();
    response.fold(
      (l) => null,
      (r) {
        emit(
          BuddyState.gotBuddy(
            state.data.copyWith(
                isLoading: false,
                buddyState: r.buddyState,
                buddy: r.buddy,
                liveTogether: r.buddy?.invitation?.liveTogether,
                relation: r.buddy?.invitation?.relation,
                email: r.buddy?.email),
          ),
        );
        if (event.needNavigate) {
          emit(BuddyState.removedBuddy(state.data.copyWith(
            isLoading: false,
            currentQuestion: BuddyQuestions.liveTogether,
            currentStepProgress: 0,
          )));
        }
      },
    );
  }

  FutureOr<void> _onRemoveBuddy(
    RemoveBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));
    final response = await _buddyService.removeBuddy();
    response.fold(
      (l) {
        emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) => add(const BuddyEvent.getStatusBuddy(needNavigate: true)),
    );
  }

  FutureOr<void> _onResendInvitation(
    ResendInvitation event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));
    final response = await _buddyService.resendBuddy();
    response.fold(
      (l) {
        emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) => add(const BuddyEvent.getStatusBuddy()),
    );
  }

  //Todo currently not return buddyState
  FutureOr<void> _onGetBuddy(
    GetBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));

    final response = await _buddyService.getBuddy();
    response.fold(
      (l) {
        emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) => emit(
        BuddyState.gotBuddy(
          state.data.copyWith(
              isLoading: false,
              buddy: r,
              liveTogether: r.invitation!.liveTogether,
              relation: r.invitation!.relation,
              email: r.email ?? ''),
        ),
      ),
    );
  }

  FutureOr<void> _onInviteBuddy(
    InviteBuddy event,
    Emitter<BuddyState> emit,
  ) async {
    emit(BuddyState.loading(state.data.copyWith(isLoading: true)));
    if (state.data.gotAllNecessaryData) {
      final response = await _buddyService.inviteBuddy(RequestBuddy(
        liveTogether: state.data.liveTogether!,
        relation: state.data.relation!,
        email: state.data.email,
      ));
      response.fold(
        (l) => emit(BuddyState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) => add(const BuddyEvent.getStatusBuddy()),
      );
    }
  }

  FutureOr<void> _onBuddyLiveTogether(
    BuddyLiveTogether event,
    Emitter<BuddyState> emit,
  ) async {
    emit(
      BuddyState.loading(
        state.data.copyWith(liveTogether: event.liveTogether),
      ),
    );
  }

  FutureOr<void> _onBuddyRelation(
    BuddyRelation event,
    Emitter<BuddyState> emit,
  ) async {
    emit(
      BuddyState.loading(
        state.data.copyWith(relation: event.relation),
      ),
    );
  }

  FutureOr<void> _onBuddyEmail(
    BuddyEmail event,
    Emitter<BuddyState> emit,
  ) async {
    emit(
      BuddyState.loading(
        state.data.copyWith(email: event.email),
      ),
    );
  }

  FutureOr<void> _onBuddyNextQuestion(
    BuddyNextQuestion event,
    Emitter<BuddyState> emit,
  ) {
    final currentQuestion = state.data.currentQuestion;
    final nextQuestion = currentQuestion.getNextQuestion();

    final isCompleted = nextQuestion == BuddyQuestions.completed;

    if (isCompleted) {
    } else {
      emit(
        BuddyState.stateQuestion(
          state.data.copyWith(
            currentQuestion: nextQuestion,
            currentStepProgress: nextQuestion.percentage.toInt(),
          ),
        ),
      );
    }
  }

  FutureOr<void> _onBuddyPreviousQuestion(
    BuddyPreviuosQuestion event,
    Emitter<BuddyState> emit,
  ) {
    final isFirstQuestion = state.data.currentQuestion.index == 0;
    final previousQuestion = state.data.currentQuestion.getPreviousQuestion();

    if (!isFirstQuestion) {
      emit(
        BuddyState.stateQuestion(
          state.data.copyWith(
            currentQuestion: previousQuestion,
            currentStepProgress: previousQuestion.percentage.toInt(),
          ),
        ),
      );
    }
  }
}
