import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/river/application/dto/get_modules_response.dart';
import 'package:loopcare_frontend/features/river/application/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

// TODO river modules response mock
import 'package:loopcare_frontend/features/river/infrastructure/river_modules_mock.dart';

@Injectable(as: RiverService)
class APIRiverService implements RiverService {
  DioClient client;

  APIRiverService(this.client);

  @override
  Future<Either<RequestError, GetModulesResponse>> getModules() async {
    // TODO river modules response mock
    return right(GetModulesResponse.fromJson({'data': modules}));
    // TODO replace with correct url
    // return await client.get('/moods', fromJson: GetModulesResponse.fromJson);
  }

  @override
  Future<Either<RequestError, RiverModule>> getModuleById({required int moduleId}) async {
    // TODO river modules response mock
    return right(RiverModule.fromJson({'data': modules.first}));

    // TODO replace with correct url
    // return await client.get('/moods', fromJson: RiverModule.fromJson);
  }

  @override
  Future<Either<RequestError, RiverModuleItem>> updateModuleItem({
    required int moduleItemId,
    required RiverModuleItem data,
  }) async {
    // TODO replace with correct url
    return await client.patch('/moods/$id', fromJson: RiverModuleItem.fromJson);
  }

  @override
  Future<Either<RequestError, RiverModule>> updateModule({
    required int moduleId,
    required RiverModule data,
  }) async {
    // TODO river modules response mock
    return right(RiverModule.fromJson(modules.first).copyWith(isCompleted: true));
    // TODO replace with correct url
    // return await client.patch(
    //   '/moods/$id',
    //   data: data,
    //   fromJson: RiverModule.fromJson,
    // );
  }
}
