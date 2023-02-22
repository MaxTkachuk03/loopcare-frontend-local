import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_service.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/add_user_diabetes.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_types_response.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/user_diabetes_response.dart';

@Injectable(as: DiabetesService)
class APIDiabetesService implements DiabetesService {
  DioClient client;

  APIDiabetesService(this.client);

  @override
  Future<Either<RequestError, DiabetesTypesResponse>> diabetesTypes() async {
    return client
        .get('/diabetes/all-types')
        .then(parseResponse(DiabetesTypesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> saveDiabetesType(
      AddUserDiabetes data) async {
    return client.post('/diabetes', data: data);
  }

  @override
  Future<Either<RequestError, UserDiabetesResponse>>
      getUserDiabetesType() async {
    return client
        .get('/diabetes')
        .then(parseResponse(UserDiabetesResponse.fromJson));
  }
}
