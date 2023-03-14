import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/nutrition_instructions/application/dto/values_explanation_response.dart';
import 'package:loopcare_frontend/features/nutrition/nutrition_instructions/application/nutrition_service.dart';

@Injectable(as: NutritionService)
class APINutritionService implements NutritionService {
  DioClient client;

  APINutritionService(this.client);

  @override
  Future<Either<RequestError, ValuesExplanationResponse>>
      getValuesExplanation() async {
    return client
        .get('/nutrition/value-explanation')
        .then(parseResponse(ValuesExplanationResponse.fromJson));
  }
}
