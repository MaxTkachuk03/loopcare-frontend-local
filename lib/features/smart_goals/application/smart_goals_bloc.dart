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
    on<SaveGoals>(_onSaveGoals);
    on<AddReview>(_onAddReview);
    on<AddGoals>(_onAddGoals);
    on<ResetSelected>(_onResetSelected);
    on<UpdateLoggerTimes>(_onUpdateLoggerTimes);
    on<ResetLoggerTimes>(_onResetLoggerTimes);
    on<PostCompletions>(_onPostCompletions);
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

  FutureOr<void> _onSaveGoals(
    SaveGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final goals = state.data.selectedGoals.map((e) => SaveGoalsBody(smartGoalId: e.id)).toList();

    final response = await _smartGoalsService.saveGoals(goals: goals);

    response.fold(
      (l) {
        emit(SmartGoalsState.errorSaveGoals(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        state.data.selectedGoals.map((e) {
          AnalyticsEventService.instance.logEvent(
            FirebaseEvents.userSavedGoals,
            parameters: {
              CustomDefinitions.userId: account?.id,
              CustomDefinitions.title: e.title,
              CustomDefinitions.goalCategoryTitle: e.category.name,
              if (r.finishedAt != null) CustomDefinitions.timestamp: r.finishedAt!.toIso8601String(),
              if (r.lastReviewDate != null) CustomDefinitions.timePassed: r.finishedAt!.toIso8601String(),
            },
          );

          CustomerIoService.track(
            event: CIOEvents.userSavedGoals,
            attributes: {
              CIOAttributes.userId: account?.id,
              CIOAttributes.goalTitle: e.title,
              CIOAttributes.goalCategoryTitle: e.category.name,
              if (r.finishedAt != null) CIOAttributes.finishDate: r.finishedAt!.toIso8601String(),
              if (r.lastReviewDate != null) CIOAttributes.reviewLastDate: r.finishedAt!.toIso8601String(),
            },
          );
        });

        emit(SmartGoalsState.weeklySessionSaved(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
      },
    );
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
            CustomDefinitions.wantsToRepeat: event.data.isTryAgain,
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

  FutureOr<void> _onAddGoals(
    AddGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(
        SmartGoalsState.goalsLoaded(state.data.copyWith(selectedGoals: [...state.data.selectedGoals, ...event.goals])));
  }

  FutureOr<void> _onResetSelected(
    ResetSelected event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(selectedGoals: [])));
  }

  FutureOr<void> _onPostCompletions(
    PostCompletions event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.confirmProgress(
        progress: ProgressGoalData(reviewId: event.reviewId, progress: state.data.logs));

    response.fold((l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))), (r) {
      _logGoalAnalyticEvent();
      emit(SmartGoalsState.progressConfirmed(state.data.copyWith(weeklyGoalsSession: r, isLoading: false)));
    });
  }

  void _logGoalAnalyticEvent() {
    for (var log in state.data.logs) {
      AnalyticsEventService.instance.logEvent(
        FirebaseEvents.userLogGoal,
        parameters: {
          CustomDefinitions.userId: account?.id,
          CustomDefinitions.timestamp: log.date,
          CustomDefinitions.value: log.times
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

  FutureOr<void> _onUpdateLoggerTimes(
    UpdateLoggerTimes event,
    Emitter<SmartGoalsState> emit,
  ) async {
    final progressLogs = [...state.data.logs];
    final index = progressLogs.indexWhere((log) => log.date == event.goalProgress.date);
    progressLogs[index] = ProgressSmartGoalLog(date: event.goalProgress.date, times: event.goalProgress.times);
    emit(SmartGoalsState.updatedLoggerTimes(state.data.copyWith(logs: progressLogs)));
  }

  FutureOr<void> _onResetLoggerTimes(
    ResetLoggerTimes event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.updatedLoggerTimes(state.data.copyWith(logs: [])));
    final progressLogs = _matchWithUserLogs(event);
    emit(SmartGoalsState.resetedLoggerTimes(state.data.copyWith(logs: progressLogs)));
  }

  List<ProgressSmartGoalLog> _matchWithUserLogs(ResetLoggerTimes event) {
    List<DateTime> dates = [];
    List<ProgressSmartGoalLog> logs = [];
    final startDay = state.data.weeklyGoalsSession?.startedAt;
    if (startDay != null) {
      dates = getDaysOnly(start: startDay, end: DateTime.now().add(const Duration(days: 1)));
    }
    if (event.weeklyGoal.progressLogs == null) {
      for (var day in dates) {
        logs.add(ProgressSmartGoalLog(date: day.dateStringOnly, times: 0));
      }
      return logs;
    }
    for (var day in dates) {
      final log = event.weeklyGoal.progressLogs!.firstWhereOrNull((log) {
        return log.date == day;
      });

      logs.add(ProgressSmartGoalLog(date: day.dateStringOnly, times: log?.times ?? 0));
    }
    return logs;
  }
}
