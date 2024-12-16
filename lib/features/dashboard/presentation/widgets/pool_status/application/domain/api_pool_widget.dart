import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/domain/pool_module_service.dart';

import '../../../../../../../core/infrastructure/dio_client/dio_client.dart';
import 'pool_response.dart';

@Injectable(as: PoolModuleService)
class ApiPoolWidget implements PoolModuleService {
  DioClient client;

  ApiPoolWidget(this.client);

  @override
  Future<Either<RequestError, PoolResponse>> fetchPoolData() async {
    return await client.get(
      '/river/modules/latest',
      fromJson: PoolResponse.fromJson,
    );
  }

  // @override
  // Future<Either<RequestError, PoolModuleItem>> fetchPoolData() async {
  //   final dio = Dio(); // Instantiate Dio client
  //
  //   final response =
  //       await dio.get('https://dev.loopcare.xyz/river/modules/latest');
  //   print("Response Pool: ${response.data}");
  //
  //   // Parsing the response
  //   final data = PoolModuleItem.fromJson(response.data);
  //
  //   // Return the parsed data wrapped in a Right (indicating success)
  //   return Right(data);
  // }
}
