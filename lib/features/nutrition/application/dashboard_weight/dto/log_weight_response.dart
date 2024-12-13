import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';

part 'log_weight_response.g.dart';

@immutable
@JsonSerializable()
class LogWeightResponse {
  final DashboardWeightItem data;

  const LogWeightResponse(this.data);

  static LogWeightResponse fromJson(Map<String, dynamic> json) => _$LogWeightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogWeightResponseToJson(this);
}
