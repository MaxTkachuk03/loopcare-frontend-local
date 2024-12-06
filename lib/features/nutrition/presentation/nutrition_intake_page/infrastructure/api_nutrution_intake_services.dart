import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/get_nutrition_intake_response.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/domain/nutrution_intake_services.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/infrastructure/nutrition_intake_mock.dart';

@Injectable(as: NutrutionIntakeServices)
class ApiNutrutionIntakeServices implements NutrutionIntakeServices {
  ApiNutrutionIntakeServices({
    required this.client,
  });
  DioClient client;

  @override
  Future<Either<RequestError, GetNutritionIntakeResponse>> getLessons(
      {required DateTime date}) async {
    return right(GetNutritionIntakeResponse.fromJson(nutritionIntake));

    //  return await client.get(
    //   '',
    //   fromJson: GetNutritionIntakeResponse.fromJson,
    // );
  }

  @override
  Future<Either<RequestError, GetNutritionIntakeResponse>> closeDay(
      {required bool isDayClosed}) async {
    return await client.post(
      '',
      data: {
        "isDayClosed": isDayClosed,
      },
      fromJson: GetNutritionIntakeResponse.fromJson,
    );
  }
}
