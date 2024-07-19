import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/river/application/dto/get_modules_response.dart';
import 'package:loopcare_frontend/features/river/application/dto/river_module_item_state_data.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

abstract class RiverService {
  Future<Either<RequestError, GetModulesResponse>> getModules();

  Future<Either<RequestError, RiverModule>> getModuleById({required int moduleId});

  Future<Either<RequestError, RiverModuleItem>> updateModuleItemState({
    required int moduleId,
    required int moduleItemId,
    required RiverModuleItemStateData data,
  });
}
