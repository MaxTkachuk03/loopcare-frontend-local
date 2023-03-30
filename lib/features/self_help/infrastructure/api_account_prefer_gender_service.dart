import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/account_prefer_gender_response.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/all_prefer_gender_response.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/update_account_prefer_gender.dart';
import 'package:loopcare_frontend/features/self_help/application/account_prefer_gender_service.dart';

@Injectable(as: AccountPreferGenderService)
class APIAccountPreferGenderService implements AccountPreferGenderService {
  DioClient client;

  APIAccountPreferGenderService(this.client);

  @override
  Future<Either<RequestError, AllPreferGenderResponse>>
      getAllPreferGenderTypes() async {
    return client
        .get('/gender/all-types')
        .then(parseResponse(AllPreferGenderResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> savePreferGender(
      UpdateAccountPreferGender data) async {
    return client.post('/gender', data: data);
  }

  @override
  Future<Either<RequestError, AccountPreferGenderResponse>>
      getAccountPreferGenderType() async {
    return client
        .get('/gender')
        .then(parseResponse(AccountPreferGenderResponse.fromJson));
  }
}
