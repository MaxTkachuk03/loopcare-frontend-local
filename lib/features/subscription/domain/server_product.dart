import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription_plan.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_image_data.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_translation.dart';

part 'server_product.g.dart';

@immutable
@JsonSerializable()
class ServerProduct {
  final String? productId;
  final double? price;
  final SubscriptionPlan? subscriptionPlan;
  final SubscriptionTranslation? subscriptionTranslation;
  final List<SubscriptionImageData>? carouselImages;

  factory ServerProduct.fromJson(Map<String, dynamic> json) => _$ServerProductFromJson(json);

  const ServerProduct({
    this.productId,
    this.price,
    this.subscriptionPlan,
    this.subscriptionTranslation,
    this.carouselImages,
  });

  Map<String, dynamic> toJson() => _$ServerProductToJson(this);
}
