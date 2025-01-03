import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_content_v2.dart';

part 'subscription_plan_v2.freezed.dart';
part 'subscription_plan_v2.g.dart';

@freezed
class SubscriptionPlanV2 with _$SubscriptionPlanV2 {
  factory SubscriptionPlanV2({
    required int id,
    required String type,
    required String productId,
    required bool isLimited,
    required double price,
    required int savings,
    required String status,
    required String title,
    required List<SubscriptionPlanContentV2> content,
  }) = _SubscriptionPlanV2;

  factory SubscriptionPlanV2.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanV2FromJson(json);
}
