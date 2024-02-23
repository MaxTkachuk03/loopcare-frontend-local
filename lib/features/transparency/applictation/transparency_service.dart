import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/features/transparency/domain/device_info.dart';

import '../../../core/infrastructure/dio_client/request_error.dart';

abstract class TransparencyService {
  Future<Either<RequestError, dynamic>> saveDeviceInfo(DeviceInfo data);
}
