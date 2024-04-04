import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_categories_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_response.dart';

abstract class SmartGoalsService {
  Future<Either<RequestError, GetGoalsResponse>> getGoals({required int categoryId});

  Future<Either<RequestError, SaveGoalsResponse>> saveGoals({required List<SaveGoalsBody> goals});

  Future<Either<RequestError, GetGoalsCategoriesResponse>> getGoalsCategories();
}
