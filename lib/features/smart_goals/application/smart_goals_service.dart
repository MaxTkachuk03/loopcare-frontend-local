import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/cancel_goal_reason.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_categories_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_statistics_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/goal_review_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/get_weekly_sessions_response.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_goal_data.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

abstract class SmartGoalsService {
  Future<Either<RequestError, GetGoalsResponse>> getGoals({required int categoryId});

  Future<Either<RequestError, WeeklyGoalsSession>> saveGoals({required SaveGoalsBody goal});

  Future<Either<RequestError, WeeklyGoalsSession>> deleteSession(
      {required int sessionId, required CancelGoalReason reason});

  Future<Either<RequestError, GetWeeklySessionsResponse>> getWeeklySessions();

  Future<Either<RequestError, GetGoalsCategoriesResponse>> getGoalsCategories();

  Future<Either<RequestError, GetGoalsStatisticsResponse>> getGoalsStatistics();

  Future<Either<RequestError, WeeklyGoalsSession>> addGoalReview(GoalReviewBody data);

  Future<Either<RequestError, dynamic>> confirmProgress({required ProgressGoalData progress});

  Future<Either<RequestError, dynamic>> resetProgress({required int sessionId});
}
