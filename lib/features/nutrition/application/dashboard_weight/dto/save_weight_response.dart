import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';

part 'save_weight_response.g.dart';

@immutable
@JsonSerializable()
class SaveWeightResponse {
  final DashboardWeightItem data;

  const SaveWeightResponse(this.data);

  static SaveWeightResponse fromJson(Map<String, dynamic> json) =>
      _$SaveWeightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveWeightResponseToJson(this);
}
