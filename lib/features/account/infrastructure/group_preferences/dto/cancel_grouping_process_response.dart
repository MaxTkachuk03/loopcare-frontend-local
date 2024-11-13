import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';

part 'cancel_grouping_process_response.g.dart';

@immutable
@JsonSerializable()
class CancelGroupingProcessResponse {
  final UserGroupingState groupingState;
  final String? groupingStartedAt;

  const CancelGroupingProcessResponse(
    this.groupingState,
    this.groupingStartedAt,
  );

  static CancelGroupingProcessResponse fromJson(Map<String, dynamic> json) =>
      _$CancelGroupingProcessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelGroupingProcessResponseToJson(this);
}
