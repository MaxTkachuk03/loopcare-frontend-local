import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_categories_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';

// TODO use to mock goals categories server response
import 'package:loopcare_frontend/features/smart_goals/infrastructure/get_smart_goals_categories_mock.dart';

@Injectable(as: SmartGoalsService)
class APISmartGoalsService implements SmartGoalsService {
  DioClient client;

  APISmartGoalsService(this.client);

  @override
  Future<Either<RequestError, GetGoalsResponse>> getGoals() async {
    // TODO replace with relevant url
    return client.get('/physical-activities/programs').then(parseResponse(GetGoalsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetGoalsCategoriesResponse>> getGoalsCategories() async {
    // TODO use to mock goals categories server response
    return right(GetGoalsCategoriesResponse.fromJson({'data': goalsCategories}));

    // return client.get('/smart-goal/categories').then(parseResponse(GetGoalsCategoriesResponse.fromJson));
  }
}
