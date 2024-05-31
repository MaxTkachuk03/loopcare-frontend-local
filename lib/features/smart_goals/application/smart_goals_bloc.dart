import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/cancel_goal_reason.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/goal_review_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_goal_data.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_smart_goal_log.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/injection.dart';

part 'smart_goals_bloc.freezed.dart';
part 'smart_goals_event.dart';
part 'smart_goals_state.dart';

const sessionReviewDelay = 7;

@singleton
class SmartGoalsBloc extends Bloc<SmartGoalsEvent, SmartGoalsState> {
  final SmartGoalsService _smartGoalsService;
  final account = getIt<SharedStorageService>().account;

  SmartGoalsBloc(this._smartGoalsService) : super(const SmartGoalsState.initial(SmartGoalsStateData())) {
    on<GetGoals>(_onGetGoals);
    on<GetWeeklyGoals>(_onGetWeeklyGoals);
    on<SetGoals>(_onSetGoals);
    on<AddReview>(_onAddReview);
    on<PostCompletions>(_onPostCompletions);
    on<ResetCompletions>(_onResetCompletions);
    on<DeleteSession>(_onDeleteSession);
    on<SelectCancelGoalReason>(_onSelectCancelReason);
    on<ResetCancelGoalReason>(_onResetCancelReason);
    on<SelectDate>(_onSelectDate);
  }

  FutureOr<void> _onSelectDate(
    SelectDate event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(selectedDate: event.selectedDate)));
  }

  FutureOr<void> _onGetGoals(
    GetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getGoals(categoryId: event.categoryId);

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.goalsLoaded(state.data.copyWith(goals: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onGetWeeklyGoals(
    GetWeeklyGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getWeeklyGoals();

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.gotWeeklySession(state.data.copyWith(weeklyGoalsSession: r, isLoading: false))),
    );
  }

  FutureOr<void> _onSetGoals(
    SetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.saveGoals(goals: [SaveGoalsBody(smartGoalId: event.goal.id)]);
    response.fold(
      (l) {
        emit(SmartGoalsState.errorSaveGoals(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        _addGoalAnalyticEvent(r);
        emit(SmartGoalsState.weeklySessionSaved(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
      },
    );
  }

  FutureOr<void> _onResetCancelReason(
    ResetCancelGoalReason event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(reason: null)));
  }

  FutureOr<void> _onSelectCancelReason(
    SelectCancelGoalReason event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(reason: event.reason)));
  }

  FutureOr<void> _onDeleteSession(
    DeleteSession event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.deleteSession(sessionId: event.sessionId, reason: state.data.reason!);

    response.fold(
      (l) {
        emit(
          SmartGoalsState.errorSaveGoals(
            state.data.copyWith(
              error: l,
              isLoading: false,
              reason: null,
            ),
          ),
        );
      },
      (r) {
        emit(
          SmartGoalsState.sessionDeleted(
            state.data.copyWith(weeklyGoalsSession: null, reason: null, isLoading: false),
          ),
        );
      },
    );
    emit(SmartGoalsState.sessionDeleted(state.data.copyWith(isLoading: false, reason: null)));
  }

  void _addGoalAnalyticEvent(WeeklyGoalsSession session) {
    if (session.sessionHasGoal) {
      final goal = session.goals!.first;
      AnalyticsEventService.instance.logEvent(
        FirebaseEvents.userSavedGoals,
        parameters: {
          CustomDefinitions.userId: account?.id,
          CustomDefinitions.title: goal.title,
          CustomDefinitions.goalCategoryTitle: goal.smartGoal.category.name,
          //Discussed with Souni and Paul  limit custom dimensions
          CustomDefinitions.timestamp: session.startedAt!.toIso8601String(),
          if (session.finishedAt != null) CustomDefinitions.timePassed: session.finishedAt!.toIso8601String(),
        },
      );

      CustomerIoService.track(
        event: CIOEvents.userSavedGoals,
        attributes: {
          CIOAttributes.userId: account?.id,
          CIOAttributes.goalTitle: goal.title,
          CIOAttributes.goalCategoryTitle: goal.smartGoal.category.name,
          if (session.finishedAt != null) CIOAttributes.finishDate: session.finishedAt!.toIso8601String(),
          if (session.lastReviewDate != null) CIOAttributes.reviewLastDate: session.finishedAt!.toIso8601String(),
        },
      );
    }
  }

  FutureOr<void> _onAddReview(
    AddReview event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.addGoalReview(event.data);

    response.fold(
      (l) {
        emit(SmartGoalsState.errorAddingReview(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        AnalyticsEventService.instance.logEvent(
          FirebaseEvents.userAddedReview,
          parameters: {
            CustomDefinitions.userId: account?.id,
            CustomDefinitions.goalCategoryTitle: event.data.categoryTitle,
            CustomDefinitions.title: event.data.goalTitle,
            CustomDefinitions.score: event.data.difficulty,
            CustomDefinitions.wantsToRepeat: event.data.isTryAgain.toString(),
          },
        );

        CustomerIoService.track(
          event: CIOEvents.userAddedReview,
          attributes: {
            CIOAttributes.userId: account?.id,
            CIOAttributes.goalCategoryTitle: event.data.categoryTitle,
            CIOAttributes.goalTitle: event.data.goalTitle,
            CIOAttributes.score: event.data.difficulty,
            CIOAttributes.wantsToRepeat: event.data.isTryAgain,
          },
        );

        emit(SmartGoalsState.reviewAdded(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
      },
    );
  }

  FutureOr<void> _onPostCompletions(
    PostCompletions event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));
    final date = state.data.selectedDate?.dateStringOnly ?? DateTime.now().dateStringOnly;
    final logs = event.weeklySmartGoal.progressLogs;
    ProgressSmartGoalLog smartGoalLog = ProgressSmartGoalLog(date: date, times: 1);
    if (logs != null) {
      final log = logs.firstWhereOrNull((log) {
        return log.date.dateStringOnly == date;
      });
      smartGoalLog = ProgressSmartGoalLog(date: date, times: (log?.times ?? 0) + 1);
    }
    final response = await _smartGoalsService.confirmProgress(
        progress: ProgressGoalData(reviewId: event.weeklySmartGoal.id, progress: [smartGoalLog]));

    response.fold((l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))), (r) {
      _logGoalAnalyticEvent(smartGoalLog);
      emit(SmartGoalsState.progressConfirmed(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
    });
  }

  FutureOr<void> _onResetCompletions(
    ResetCompletions event,
    Emitter<SmartGoalsState> emit,
  ) async {
    final date = state.data.selectedDate?.dateStringOnly ?? DateTime.now().dateStringOnly;
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));
    final response = await _smartGoalsService.confirmProgress(
        progress: ProgressGoalData(
            reviewId: event.weeklySmartGoal.id, progress: [ProgressSmartGoalLog(date: date, times: 0)]));

    response.fold((l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))), (r) {
      emit(SmartGoalsState.progressConfirmed(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
    });
  }

  void _logGoalAnalyticEvent(ProgressSmartGoalLog log) {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userLogGoal,
      parameters: {
        CustomDefinitions.userId: account?.id,
        CustomDefinitions.value: log.times,
        CustomDefinitions.timestamp: log.date,
      },
    );
    CustomerIoService.track(
      event: CIOEvents.userLogGoal,
      attributes: {
        CIOAttributes.userId: account?.id,
        CIOAttributes.logValue: log.times,
        CIOAttributes.dateLog: log.date,
      },
    );
  }
}
