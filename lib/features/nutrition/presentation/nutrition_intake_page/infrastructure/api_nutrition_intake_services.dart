import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/get_nutrition_intake_response.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/domain/nutrition_intake_services.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/infrastructure/nutrition_intake_mock.dart';

@Injectable(as: NutritionIntakeServices)
class ApiNutritionIntakeServices implements NutritionIntakeServices {
  ApiNutritionIntakeServices({
    required this.client,
  });

  DioClient client;

  @override
  Future<Either<RequestError, GetNutritionIntakeResponse>> getLessons(
      {required DateTime date}) async {
    // return right(GetNutritionIntakeResponse.fromJson(nutritionIntake));

    String convertedDate = DateFormat("yyyy-MM-dd").format(date);

    try {
      final response = await client.get(
        '/smart-goal/goal-progress',
        queryParameters: {"date": convertedDate},
        fromJson: GetNutritionIntakeResponse.fromJson,
      );
      log.d('Raw Response: response !!!!!!!!!!!!!!');
      return response;
    } catch (e, stackTrace) {
      log.w('Error in client.get: $e');
      log.w('Stack Trace: $stackTrace');
      rethrow; // Optional: rethrow the error for further handling
    }
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
