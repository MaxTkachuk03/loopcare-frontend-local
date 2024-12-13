<<<<<<< HEAD
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
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
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'smart_goals_bloc.freezed.dart';
part 'smart_goals_event.dart';
part 'smart_goals_state.dart';

const sessionReviewDelay = 7;

@singleton
class SmartGoalsBloc extends Bloc<SmartGoalsEvent, SmartGoalsState> {
  final SmartGoalsService _smartGoalsService;
  final account = getIt<SharedStorageService>().account;
  final usageAnalytics = UsageAnalytics();

  SmartGoalsBloc(this._smartGoalsService)
      : super(const SmartGoalsState.initial(SmartGoalsStateData())) {
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
      (r) =>
          emit(SmartGoalsState.goalsLoaded(state.data.copyWith(goals: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onGetWeeklyGoals(
    GetWeeklyGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getWeeklySessions();

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.gotWeeklySession(
          state.data.copyWith(weeklyGoalsSessions: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onSetGoals(
    SetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response =
        await _smartGoalsService.saveGoals(goal: SaveGoalsBody(smartGoalId: event.goal.id));
    response.fold(
      (l) {
        emit(SmartGoalsState.errorSaveGoals(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        _addGoalAnalyticEvent(r);
        emit(SmartGoalsState.weeklySessionSaved(state.data.copyWith(
            weeklyGoalsSessions: [...state.data.weeklyGoalsSessions, r], isLoading: false)));
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

    final response = await _smartGoalsService.deleteSession(
        sessionId: event.sessionId, reason: state.data.reason!);

    response.fold(
      (l) => emit(
        SmartGoalsState.errorSaveGoals(
          state.data.copyWith(
            error: l,
            isLoading: false,
            reason: null,
          ),
        ),
      ),
      (r) {
        var sessions = [...state.data.weeklyGoalsSessions];
        final deletedSession = sessions.firstWhere((s) => s.id == r.id);
        sessions.removeWhere((session) => session.id == r.id);
        usageAnalytics.track(
          eventName: UsageAnalyticsEvents.goalNutritionDeleted,
          attributes: {
            UsageAnalyticsAttributes.goalTitle: deletedSession.goal?.title,
            UsageAnalyticsAttributes.goalID: deletedSession.goal?.id,
            UsageAnalyticsAttributes.goalCategoryTitle:
                deletedSession.goal?.smartGoal.category.name,
            UsageAnalyticsAttributes.goalCategoryID: deletedSession.goal?.smartGoal.category.id,
            UsageAnalyticsAttributes.allottedDays: deletedSession.goal?.requiredDays,
            UsageAnalyticsAttributes.requiredCompletions: deletedSession.goal?.requiredCompletions,
            UsageAnalyticsAttributes.deletionReason: state.data.reason?.label,
            if (deletedSession.finishedAt != null)
              UsageAnalyticsAttributes.finishDate: deletedSession.finishedAt!.toIso8601String(),
          },
        );
        emit(
          SmartGoalsState.sessionDeleted(
            state.data.copyWith(weeklyGoalsSessions: sessions, reason: null, isLoading: false),
          ),
        );
      },
    );
    emit(SmartGoalsState.sessionDeleted(state.data.copyWith(isLoading: false, reason: null)));
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
        _logOnAddReview(event.data);

        var sessions = [...state.data.weeklyGoalsSessions];
        sessions.removeWhere((session) => session.id == r.id);

        emit(
          SmartGoalsState.reviewAdded(
            state.data.copyWith(weeklyGoalsSessions: sessions, isLoading: false),
          ),
        );
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
      final log = logs.firstWhereOrNull((log) => log.date.dateStringOnly == date);
      smartGoalLog = ProgressSmartGoalLog(date: date, times: (log?.times ?? 0) + 1);
    }

    final response = await _smartGoalsService.confirmProgress(
      progress: ProgressGoalData(reviewId: event.weeklySmartGoal.id, progress: [smartGoalLog]),
    );

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        _logGoalAnalyticEvent(smartGoalLog, event.weeklySmartGoal);
        var sessions = [...state.data.weeklyGoalsSessions];
        final index = sessions.indexWhere((session) => session.id == r.id);
        sessions[index] = r;

        emit(
          SmartGoalsState.progressConfirmed(
            state.data.copyWith(weeklyGoalsSessions: [...sessions], isLoading: false),
          ),
        );
      },
    );
  }

  FutureOr<void> _onResetCompletions(
    ResetCompletions event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));
    final response = await _smartGoalsService.resetProgress(progressId: event.progressId);

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        var sessions = [...state.data.weeklyGoalsSessions];
        final index = sessions.indexWhere((session) => session.id == r.id);
        sessions[index] = r;

        emit(
          SmartGoalsState.progressReset(
            state.data.copyWith(weeklyGoalsSessions: [...sessions], isLoading: false),
          ),
        );
      },
    );
  }

  void _logGoalAnalyticEvent(ProgressSmartGoalLog log, WeeklySmartGoal smartGoal) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userLogGoal,
      parameters: {
        AnalyticsParameters.userId: account?.id ?? -1,
        AnalyticsParameters.value: log.times,
        AnalyticsParameters.timestamp: log.date,
      },
    );

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.goalNutritionLogged,
      attributes: {
        UsageAnalyticsAttributes.logValue: log.times,
        UsageAnalyticsAttributes.dateLog: log.date,
        UsageAnalyticsAttributes.goalID: smartGoal.id.toString(),
        UsageAnalyticsAttributes.goalTitle: smartGoal.title,
        UsageAnalyticsAttributes.goalCategoryID: smartGoal.smartGoal.category.id.toString(),
        UsageAnalyticsAttributes.goalCategoryTitle: smartGoal.smartGoal.category.name,
        UsageAnalyticsAttributes.allottedDays: smartGoal.requiredDays,
        UsageAnalyticsAttributes.requiredCompletions: smartGoal.requiredCompletions,
      },
    );
  }

  void _logOnAddReview(GoalReviewBody data) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userAddedReview,
      parameters: {
        AnalyticsParameters.userId: account?.id ?? -1,
        AnalyticsParameters.goalCategoryTitle: data.categoryTitle,
        AnalyticsParameters.title: data.goalTitle,
        AnalyticsParameters.score: data.difficulty,
        AnalyticsParameters.wantsToRepeat: data.isTryAgain.toString(),
      },
    );

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.goalNutritionCompleted,
      attributes: {
        UsageAnalyticsAttributes.goalCategoryTitle: data.categoryTitle,
        UsageAnalyticsAttributes.goalTitle: data.goalTitle,
        UsageAnalyticsAttributes.score: data.difficulty,
        UsageAnalyticsAttributes.wantsToRepeat: data.isTryAgain,
      },
    );
  }

  void _addGoalAnalyticEvent(WeeklyGoalsSession session) {
    if (session.sessionHasGoal) {
      final goal = session.goal!;
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.userSavedGoals,
        parameters: {
          AnalyticsParameters.userId: account?.id ?? -1,
          AnalyticsParameters.title: goal.title,
          AnalyticsParameters.goalCategoryTitle: goal.smartGoal.category.name,
          //Discussed with Souni and Paul  limit custom dimensions
          if (session.startedAt != null)
            AnalyticsParameters.timestamp: session.startedAt!.toIso8601String(),
          if (session.finishedAt != null)
            AnalyticsParameters.timePassed: session.finishedAt!.toIso8601String(),
        },
      );

      usageAnalytics.track(
        eventName: UsageAnalyticsEvents.goalNutritionSelected,
        attributes: {
          UsageAnalyticsAttributes.goalTitle: goal.title,
          UsageAnalyticsAttributes.goalID: goal.id,
          UsageAnalyticsAttributes.goalCategoryTitle: goal.smartGoal.category.name,
          UsageAnalyticsAttributes.goalCategoryID: goal.smartGoal.category.id,
          UsageAnalyticsAttributes.allottedDays: goal.requiredDays,
          UsageAnalyticsAttributes.requiredCompletions: goal.requiredCompletions,
          if (session.finishedAt != null)
            UsageAnalyticsAttributes.finishDate: session.finishedAt!.toIso8601String(),
        },
      );
    }
  }
}
=======
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
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
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'smart_goals_bloc.freezed.dart';
part 'smart_goals_event.dart';
part 'smart_goals_state.dart';

const sessionReviewDelay = 7;

@singleton
class SmartGoalsBloc extends Bloc<SmartGoalsEvent, SmartGoalsState> {
  final SmartGoalsService _smartGoalsService;
  final account = getIt<SharedStorageService>().account;
  final usageAnalytics = UsageAnalytics();

  SmartGoalsBloc(this._smartGoalsService)
      : super(const SmartGoalsState.initial(SmartGoalsStateData())) {
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
      (r) =>
          emit(SmartGoalsState.goalsLoaded(state.data.copyWith(goals: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onGetWeeklyGoals(
    GetWeeklyGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getWeeklySessions();

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.gotWeeklySession(
          state.data.copyWith(weeklyGoalsSessions: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onSetGoals(
    SetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response =
        await _smartGoalsService.saveGoals(goal: SaveGoalsBody(smartGoalId: event.goal.id));
    response.fold(
      (l) {
        emit(SmartGoalsState.errorSaveGoals(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        _addGoalAnalyticEvent(r);
        emit(SmartGoalsState.weeklySessionSaved(state.data.copyWith(
            weeklyGoalsSessions: [...state.data.weeklyGoalsSessions, r], isLoading: false)));
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

    final response = await _smartGoalsService.deleteSession(
        sessionId: event.sessionId, reason: state.data.reason!);

    response.fold(
      (l) => emit(
        SmartGoalsState.errorSaveGoals(
          state.data.copyWith(
            error: l,
            isLoading: false,
            reason: null,
          ),
        ),
      ),
      (r) {
        var sessions = [...state.data.weeklyGoalsSessions];
        final deletedSession = sessions.firstWhere((s) => s.id == r.id);
        sessions.removeWhere((session) => session.id == r.id);
        usageAnalytics.track(
          eventName: UsageAnalyticsEvents.goalNutritionDeleted,
          attributes: {
            UsageAnalyticsAttributes.goalTitle: deletedSession.goal?.title,
            UsageAnalyticsAttributes.goalID: deletedSession.goal?.id,
            UsageAnalyticsAttributes.goalCategoryTitle:
                deletedSession.goal?.smartGoal.category.name,
            UsageAnalyticsAttributes.goalCategoryID: deletedSession.goal?.smartGoal.category.id,
            UsageAnalyticsAttributes.allottedDays: deletedSession.goal?.requiredDays,
            UsageAnalyticsAttributes.requiredCompletions: deletedSession.goal?.requiredCompletions,
            UsageAnalyticsAttributes.deletionReason: state.data.reason?.label,
            if (deletedSession.finishedAt != null)
              UsageAnalyticsAttributes.finishDate: deletedSession.finishedAt!.toIso8601String(),
          },
        );
        emit(
          SmartGoalsState.sessionDeleted(
            state.data.copyWith(weeklyGoalsSessions: sessions, reason: null, isLoading: false),
          ),
        );
      },
    );
    emit(SmartGoalsState.sessionDeleted(state.data.copyWith(isLoading: false, reason: null)));
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
        _logOnAddReview(event.data);

        var sessions = [...state.data.weeklyGoalsSessions];
        sessions.removeWhere((session) => session.id == r.id);

        emit(
          SmartGoalsState.reviewAdded(
            state.data.copyWith(weeklyGoalsSessions: sessions, isLoading: false),
          ),
        );
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
      final log = logs.firstWhereOrNull((log) => log.date.dateStringOnly == date);
      smartGoalLog = ProgressSmartGoalLog(date: date, times: (log?.times ?? 0) + 1);
    }

    final response = await _smartGoalsService.confirmProgress(
      progress: ProgressGoalData(reviewId: event.weeklySmartGoal.id, progress: [smartGoalLog]),
    );

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        _logGoalAnalyticEvent(smartGoalLog, event.weeklySmartGoal);
        var sessions = [...state.data.weeklyGoalsSessions];
        final index = sessions.indexWhere((session) => session.id == r.id);
        sessions[index] = r;

        emit(
          SmartGoalsState.progressConfirmed(
            state.data.copyWith(weeklyGoalsSessions: [...sessions], isLoading: false),
          ),
        );
      },
    );
  }

  FutureOr<void> _onResetCompletions(
    ResetCompletions event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));
    final response = await _smartGoalsService.resetProgress(progressId: event.progressId);

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        var sessions = [...state.data.weeklyGoalsSessions];
        final index = sessions.indexWhere((session) => session.id == r.id);
        sessions[index] = r;

        emit(
          SmartGoalsState.progressReset(
            state.data.copyWith(weeklyGoalsSessions: [...sessions], isLoading: false),
          ),
        );
      },
    );
  }

  void _logGoalAnalyticEvent(ProgressSmartGoalLog log, WeeklySmartGoal smartGoal) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userLogGoal,
      parameters: {
        AnalyticsParameters.userId: account?.id ?? -1,
        AnalyticsParameters.value: log.times,
        AnalyticsParameters.timestamp: log.date,
      },
    );

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.goalNutritionLogged,
      attributes: {
        UsageAnalyticsAttributes.logValue: log.times,
        UsageAnalyticsAttributes.dateLog: log.date,
        UsageAnalyticsAttributes.goalID: smartGoal.id.toString(),
        UsageAnalyticsAttributes.goalTitle: smartGoal.title,
        UsageAnalyticsAttributes.goalCategoryID: smartGoal.smartGoal.category.id.toString(),
        UsageAnalyticsAttributes.goalCategoryTitle: smartGoal.smartGoal.category.name,
        UsageAnalyticsAttributes.allottedDays: smartGoal.requiredDays,
        UsageAnalyticsAttributes.requiredCompletions: smartGoal.requiredCompletions,
      },
    );
  }

  void _logOnAddReview(GoalReviewBody data) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userAddedReview,
      parameters: {
        AnalyticsParameters.userId: account?.id ?? -1,
        AnalyticsParameters.goalCategoryTitle: data.categoryTitle,
        AnalyticsParameters.title: data.goalTitle,
        AnalyticsParameters.score: data.difficulty,
        AnalyticsParameters.wantsToRepeat: data.isTryAgain.toString(),
      },
    );

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.goalNutritionCompleted,
      attributes: {
        UsageAnalyticsAttributes.goalCategoryTitle: data.categoryTitle,
        UsageAnalyticsAttributes.goalTitle: data.goalTitle,
        UsageAnalyticsAttributes.score: data.difficulty,
        UsageAnalyticsAttributes.wantsToRepeat: data.isTryAgain,
      },
    );
  }

  void _addGoalAnalyticEvent(WeeklyGoalsSession session) {
    if (session.sessionHasGoal) {
      final goal = session.goal!;
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.userSavedGoals,
        parameters: {
          AnalyticsParameters.userId: account?.id ?? -1,
          AnalyticsParameters.title: goal.title,
          AnalyticsParameters.goalCategoryTitle: goal.smartGoal.category.name,
          //Discussed with Souni and Paul  limit custom dimensions
          if (session.startedAt != null)
            AnalyticsParameters.timestamp: session.startedAt!.toIso8601String(),
          if (session.finishedAt != null)
            AnalyticsParameters.timePassed: session.finishedAt!.toIso8601String(),
        },
      );

      usageAnalytics.track(
        eventName: UsageAnalyticsEvents.goalNutritionSelected,
        attributes: {
          UsageAnalyticsAttributes.goalTitle: goal.title,
          UsageAnalyticsAttributes.goalID: goal.id,
          UsageAnalyticsAttributes.goalCategoryTitle: goal.smartGoal.category.name,
          UsageAnalyticsAttributes.goalCategoryID: goal.smartGoal.category.id,
          UsageAnalyticsAttributes.allottedDays: goal.requiredDays,
          UsageAnalyticsAttributes.requiredCompletions: goal.requiredCompletions,
          if (session.finishedAt != null)
            UsageAnalyticsAttributes.finishDate: session.finishedAt!.toIso8601String(),
        },
      );
    }
  }
}
>>>>>>> feature-interactive-lessons
