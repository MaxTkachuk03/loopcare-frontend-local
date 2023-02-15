import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_service.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_types_response.dart';

@Injectable(as: DiabetesService)
class APIDiabetesService implements DiabetesService {
  DioClient client;

  APIDiabetesService(this.client);

  @override
  Future<Either<RequestError, DiabetesTypesResponse>> diabetesTypes() async {
    return client
        .get('/diabetes')
        .then(parseResponse(DiabetesTypesResponse.fromJson));
  }

  // @override
  // Future<Either<RequestError, FoodPreferenceResponse>>
  //     foodPrefsPeriods() async {
  //   return client
  //       .get('/food-preferences/periods')
  //       .then(parseResponse(FoodPreferenceResponse.fromJson));
  // }
  //
  // @override
  // Future<Either<RequestError, FoodPreferenceResponse>> foodPrefsItems() async {
  //   return client
  //       .get('/food-preferences/periods')
  //       .then(parseResponse(FoodPreferenceResponse.fromJson));
  // }
  //
  // @override
  // Future<Either<RequestError, dynamic>> foodPrefsSave(
  //     FoodPrefsData data) async {
  //   return client
  //       .post('/food-preferences', data: data)
  //       .then(parseResponse(FoodPreferenceResponse.fromJson));
  // }
}
