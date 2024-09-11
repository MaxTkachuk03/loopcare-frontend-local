import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_weight_item.freezed.dart';

part 'dashboard_weight_item.g.dart';

@freezed
class DashboardWeightItem with _$DashboardWeightItem {
  const factory DashboardWeightItem({
    required double weight,
    required DateTime date,
  }) = _DashboardWeightItem;

  factory DashboardWeightItem.fromJson(Map<String, dynamic> json) =>
      _$DashboardWeightItemFromJson(json);
}
