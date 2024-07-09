import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/application/dto/cancel_grouping_process_response.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_body.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_response.dart';
import 'package:loopcare_frontend/features/account/application/dto/leave_group_response.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_service.dart';

@Injectable(as: GroupPreferencesService)
class APIGroupPreferencesService implements GroupPreferencesService {
  DioClient client;

  APIGroupPreferencesService(this.client);

  @override
  Future<Either<RequestError, GroupPreferencesResponse>> savePreferences(GroupPreferencesBody data) async {
    return await client.post(
      '/grouping/preferences',
      data: data,
      fromJson: GroupPreferencesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, CancelGroupingProcessResponse>> cancelGroupingProcess() async {
    return await client.patch(
      '/grouping/cancel',
      fromJson: CancelGroupingProcessResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, LeaveGroupResponse>> leaveGroup() async {
    return await client.patch(
      '/grouping/leave-group',
      fromJson: LeaveGroupResponse.fromJson,
    );
  }
}
