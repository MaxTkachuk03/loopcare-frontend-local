import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan_content_v2.freezed.dart';
part 'subscription_plan_content_v2.g.dart';

@freezed
class SubscriptionPlanContentV2 with _$SubscriptionPlanContentV2 {
  factory SubscriptionPlanContentV2({
    required int id,
    required String text,
  }) = _SubscriptionPlanContentV2;

  factory SubscriptionPlanContentV2.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanContentV2FromJson(json);
}
