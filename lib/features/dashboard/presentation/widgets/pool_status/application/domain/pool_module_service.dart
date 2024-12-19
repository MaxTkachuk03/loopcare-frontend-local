import 'package:dartz/dartz.dart';

import '../../../../../../../core/infrastructure/dio_client/request_error.dart';
import 'pool_response.dart';

abstract class PoolModuleService {
  Future<Either<RequestError, PoolResponse>> fetchPoolData();
}
