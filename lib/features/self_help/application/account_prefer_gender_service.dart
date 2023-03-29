import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/all_prefer_gender_response.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/update_account_prefer_gender.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/account_prefer_gender_response.dart';

abstract class AccountPreferGenderService {
  Future<Either<RequestError, AllPreferGenderResponse>>
      getAllPreferGenderTypes();

  Future<Either<RequestError, dynamic>> savePreferGender(
      UpdateAccountPreferGender data);

  Future<Either<RequestError, AccountPreferGenderResponse>>
      getAccountPreferGenderType();
}
