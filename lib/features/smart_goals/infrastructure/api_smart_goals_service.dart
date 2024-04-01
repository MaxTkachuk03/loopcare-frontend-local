import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';

@Injectable(as: SmartGoalsService)
class APISmartGoalsService implements SmartGoalsService {
  DioClient client;

  APISmartGoalsService(this.client);

  @override
  Future<Either<RequestError, GetGoalsResponse>> getGoals() {
    // TODO replace with relevant url
    return client.get('/physical-activities/programs').then(parseResponse(GetGoalsResponse.fromJson));
  }
}
