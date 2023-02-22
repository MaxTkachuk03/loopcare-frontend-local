import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

@Injectable(as: PreferGenderService)
class APIPreferGenderService implements PreferGenderService {
  DioClient client;

  APIPreferGenderService(this.client);

  @override
  Future<Either<RequestError, AllPreferGenderResponse>> getAllPreferGenderTypes() async {
    return client
        .get('/gender/all-types')
        .then(parseResponse(PreferGenderResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> savePreferGender(
      UpdatePreferGender data) async {
    return client.post('/gender', data: data);
  }

  @override
  Future<Either<RequestError, UserPreferGenderResponse>>
      getUserPreferGenderType() async {
    return client
        .get('/gender')
        .then(parseResponse(UserPreferGenderResponse.fromJson));
  }
}
