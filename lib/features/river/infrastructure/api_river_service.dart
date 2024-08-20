import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/river/domain/river_service.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/get_modules_response.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/river_module_item_state_data.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/river_module_state_data.dart';
import 'package:loopcare_frontend/features/river/infrastructure/dto/get_cross_module_items_response.dart';

// TODO river modules response mock
//import 'package:loopcare_frontend/features/river/infrastructure/river_modules_mock.dart';
//import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_mock.dart';

@Injectable(as: RiverService)
class APIRiverService implements RiverService {
  DioClient client;

  APIRiverService(this.client);

  @override
  Future<Either<RequestError, GetModulesResponse>> getModules() {
    // TODO river modules response mock
    // return Future.value(right(GetModulesResponse.fromJson({'data': modules})));
    return client.get('/river/modules', fromJson: GetModulesResponse.fromJson);
  }

  @override
  Future<Either<RequestError, RiverModule>> getModuleById({required int moduleId}) {
    // TODO river modules response mock
    // return Future.value(right(RiverModule.fromJson({'data': modules[1]})));

    // TODO replace with correct url
    return client.get('/river/modules/$moduleId', fromJson: RiverModule.fromJson);
  }

  @override
  Future<Either<RequestError, RiverModuleItem>> updateModuleItemState({
    required int moduleId,
    required int moduleItemId,
    required RiverModuleItemStateData data,
  }) {
    // TODO river modules response mock
    // return Future.value(right(RiverModuleItem.fromJson(moduleItem)));
    return client.put(
      '/river/modules/$moduleId/module-items/$moduleItemId/progress',
      data: data,
      fromJson: RiverModuleItem.fromJson,
    );
  }

  @override
  Future<Either<RequestError, RiverModule>> updateModuleState({
    required int moduleId,
    required RiverModuleStateData data,
  }) {
    return client.put(
      '/river/modules/$moduleId/progress',
      data: data,
      fromJson: RiverModule.fromJson,
    );
  }

  @override
  Future<Either<RequestError, GetCrossModuleItemsResponse>> getDeferredModuleItems() {
    return client.get(
      '/river/modules/module-items/deferred',
      fromJson: GetCrossModuleItemsResponse.fromJson,
    );
  }
}
