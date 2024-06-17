import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/cancel_goal_reason.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_categories_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_statistics_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/goal_review_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/get_weekly_sessions_response.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_goal_data.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

// TODO use to mock goals categories server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_smart_goals_categories_mock.dart';

// TODO use to mock goals server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_goals_list_mock.dart';

// TODO use to mock goals stats server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_goals_stats_mock.dart';

// TODO use to mock goals stats server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_weekly_goals.dart';

@Injectable(as: SmartGoalsService)
class APISmartGoalsService implements SmartGoalsService {
  DioClient client;

  APISmartGoalsService(this.client);

  @override
  Future<Either<RequestError, GetGoalsResponse>> getGoals({required int categoryId}) async {
    // TODO use to mock goals server response
    // return right(GetGoalsResponse.fromJson({'data': goals}));

    return await client.get(
      '/smart-goal/list',
      queryParameters: {"categoryId": categoryId},
      fromJson: GetGoalsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> saveGoals({required SaveGoalsBody goal}) async {
    return await client.post(
      '/smart-goal/session',
      data: goal,
      fromJson: WeeklyGoalsSession.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetGoalsCategoriesResponse>> getGoalsCategories() async {
    // TODO use to mock goals categories server response
    // return right(GetGoalsCategoriesResponse.fromJson({'data': goalsCategories}));

    return await client.get(
      '/smart-goal/categories',
      fromJson: GetGoalsCategoriesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetWeeklySessionsResponse>> getWeeklySessions() async {
    // TODO use to mock weekly goals server response
    //return right(GetWeeklySessionsResponse.fromJson(weeklyGoals));

    return await client.get(
      '/smart-goal/session/last',
      fromJson: GetWeeklySessionsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetGoalsStatisticsResponse>> getGoalsStatistics() async {
    // TODO use to mock goals stats server response
    // return right(GetGoalsStatisticsResponse.fromJson({'data': goalsStats}));

    return await client.get(
      '/smart-goal/stats',
      fromJson: GetGoalsStatisticsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> addGoalReview(GoalReviewBody data) async {
    return await client.patch(
      '/smart-goal/review',
      data: data,
      fromJson: WeeklyGoalsSession.fromJson,
    );
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> confirmProgress({required ProgressGoalData progress}) async {
    return await client.post(
      '/smart-goal/progress',
      data: progress.toJson(),
      fromJson: WeeklyGoalsSession.fromJson,
    );
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> deleteSession({
    required int sessionId,
    required CancelGoalReason reason,
  }) async {
    return await client.delete(
      '/smart-goal/session/$sessionId',
      data: {'reason': reason.name},
      fromJson: WeeklyGoalsSession.fromJson,
    );
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> resetProgress({required int sessionId}) async {
    return await client.delete('/smart-goal/progress/$sessionId', fromJson: WeeklyGoalsSession.fromJson);
  }

  @override
  Future<Either<RequestError, dynamic>> unlockCategory({required int id}) async {
    return await client.post('/smart-goal/category/$id/animation');
  }
}
