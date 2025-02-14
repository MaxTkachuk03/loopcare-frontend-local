import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';

import '../../../../../core/infrastructure/services/logger/logger.dart';

part 'get_dashboard_weights_response.g.dart';

@immutable
@JsonSerializable()
class GetDashboardWeightsResponse {
  final List<DashboardWeightItem> data;
  final Map<String, dynamic> highlights;

  const GetDashboardWeightsResponse(this.data, this.highlights);

  static GetDashboardWeightsResponse fromJson(Map<String, dynamic> json) =>
      _$GetDashboardWeightsResponseFromJson(json);

  factory GetDashboardWeightsResponse.debugFromJson(Map<String, dynamic> json) {
    try {
      final data = (json['data'] as List<dynamic>?)
              ?.map((item) => DashboardWeightItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          <DashboardWeightItem>[];
      final highlights = json['highlights'] as Map<String, dynamic>;

      final parsedHighlights = highlights.map((key, value) {
        if (key == 'weightDifference' && value is int) {
          return MapEntry(key, value.toDouble());
        }
        return MapEntry(key, value);
      });

      return GetDashboardWeightsResponse(data, parsedHighlights);
    } catch (e, stackTrace) {
      log.w('Error in GetDashboardWeightsResponse.fromJson: $e');
      log.w('Stack Trace: $stackTrace');
      log.w('Problematic JSON: $json');
      rethrow; // Ensure the error propagates up the call stack
    }
  }

  Map<String, dynamic> toJson() => _$GetDashboardWeightsResponseToJson(this);
}
