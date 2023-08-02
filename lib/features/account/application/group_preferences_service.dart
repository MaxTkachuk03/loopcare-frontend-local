import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_body.dart';
import 'package:loopcare_frontend/features/account/application/dto/group_preferences_response.dart';
import 'package:loopcare_frontend/features/account/application/dto/leave_group_response.dart';
import 'package:loopcare_frontend/features/account/application/dto/cancel_grouping_process_response.dart';

abstract class GroupPreferencesService {
  Future<Either<RequestError, GroupPreferencesResponse>> savePreferences(GroupPreferencesBody data);

  Future<Either<RequestError, CancelGroupingProcessResponse>> cancelGroupingProcess();

  Future<Either<RequestError, LeaveGroupResponse>> leaveGroup();
}
