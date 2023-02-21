import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/add_user_diabetes.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_types_response.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/user_diabetes_response.dart';

abstract class DiabetesService {
  Future<Either<RequestError, DiabetesTypesResponse>> diabetesTypes();

  Future<Either<RequestError, dynamic>> saveDiabetesType(AddUserDiabetes data);

  Future<Either<RequestError, UserDiabetesResponse>> getUserDiabetesType();
}
