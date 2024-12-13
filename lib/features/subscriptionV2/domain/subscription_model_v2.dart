import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_v2.dart';

part 'subscription_model_v2.freezed.dart';
part 'subscription_model_v2.g.dart';

@freezed
class SubscriptionModelV2 with _$SubscriptionModelV2 {
  factory SubscriptionModelV2({
    required int id,
    required String type,
    required String title,
    required String label,
    required String subText,
    required List<SubscriptionPlanV2> plans,
  }) = _SubscriptionModelV2;

  factory SubscriptionModelV2.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelV2FromJson(json);
}
