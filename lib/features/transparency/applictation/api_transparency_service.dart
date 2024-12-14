import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/transparency/applictation/transparency_service.dart';
import 'package:loopcare_frontend/features/transparency/domain/device_info.dart';

@Injectable(as: TransparencyService)
class APITransparencyService implements TransparencyService {
  DioClient client;

  APITransparencyService(this.client);

  @override
  Future<Either<RequestError, dynamic>> saveDeviceInfo(DeviceInfo data) async {
    return await client.post('/analytics/device-info', data: data);
  }
}
