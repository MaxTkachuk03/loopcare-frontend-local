import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_categories_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_statistics_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/goal_review_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';
import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_weekly_goals.dart';
// TODO use to mock goals categories server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_smart_goals_categories_mock.dart';

// TODO use to mock goals server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_goals_list_mock.dart';

// TODO use to mock goals stats server response
// import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_goals_stats_mock.dart';

@Injectable(as: SmartGoalsService)
class APISmartGoalsService implements SmartGoalsService {
  DioClient client;

  APISmartGoalsService(this.client);

  @override
  Future<Either<RequestError, GetGoalsResponse>> getGoals({required int categoryId}) async {
    // TODO use to mock goals server response
    // return right(GetGoalsResponse.fromJson({'data': goals}));

    return client.get('/smart-goal/list',
        queryParameters: {"categoryId": categoryId}).then(parseResponse(GetGoalsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> saveGoals({required List<SaveGoalsBody> goals}) async {
    return client
        .post('/smart-goal/session', data: {"goals": goals}).then(parseResponse(WeeklyGoalsSession.fromJson));
  }

  @override
  Future<Either<RequestError, GetGoalsCategoriesResponse>> getGoalsCategories() async {
    // TODO use to mock goals categories server response
    // return right(GetGoalsCategoriesResponse.fromJson({'data': goalsCategories}));

    return client.get('/smart-goal/categories').then(parseResponse(GetGoalsCategoriesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> getWeeklyGoals() async {
    return right(WeeklyGoalsSession.fromJson(weeklyGoals));
    // return client.get('/smart-goal/session/last').then(parseResponse(WeeklyGoalsSession.fromJson));
  }

  @override
  Future<Either<RequestError, GetGoalsStatisticsResponse>> getGoalsStatistics() async {
    // TODO use to mock goals stats server response
    // return right(GetGoalsStatisticsResponse.fromJson({'data': goalsStats}));

    return client.get('/smart-goal/stats').then(parseResponse(GetGoalsStatisticsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, WeeklyGoalsSession>> addGoalReview(GoalReviewBody data) async {
    return client.patch('/smart-goal/review', data: data).then(parseResponse(WeeklyGoalsSession.fromJson));
  }
}
