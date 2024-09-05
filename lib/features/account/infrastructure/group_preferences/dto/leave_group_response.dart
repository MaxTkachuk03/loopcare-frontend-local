import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';

part 'leave_group_response.g.dart';

@immutable
@JsonSerializable()
class LeaveGroupResponse {
  final UserGroupingState groupingState;
  final String? groupingStartedAt;

  const LeaveGroupResponse(
    this.groupingState,
    this.groupingStartedAt,
  );

  static LeaveGroupResponse fromJson(Map<String, dynamic> json) => _$LeaveGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveGroupResponseToJson(this);
}
