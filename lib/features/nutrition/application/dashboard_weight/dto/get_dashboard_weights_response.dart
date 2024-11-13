import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';

part 'get_dashboard_weights_response.g.dart';

@immutable
@JsonSerializable()
class GetDashboardWeightsResponse {
  final List<DashboardWeightItem> data;

  const GetDashboardWeightsResponse(this.data);

  static GetDashboardWeightsResponse fromJson(Map<String, dynamic> json) =>
      _$GetDashboardWeightsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDashboardWeightsResponseToJson(this);
}
