import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription_plan.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_translation_v2.dart';

part 'server_product_v2.g.dart';

@immutable
@JsonSerializable()
class ServerProductV2 {
  final String? productId;
  final double? price;
  final SubscriptionPlan? subscriptionPlan;
  final SubscriptionTranslationV2? subscriptionTranslation;

  factory ServerProductV2.fromJson(Map<String, dynamic> json) => _$ServerProductV2FromJson(json);

  const ServerProductV2({
    this.productId,
    this.price,
    this.subscriptionPlan,
    this.subscriptionTranslation,
  });

  Map<String, dynamic> toJson() => _$ServerProductV2ToJson(this);
}
