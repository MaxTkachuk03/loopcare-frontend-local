import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription_plan.dart';

part 'server_product.g.dart';

@immutable
@JsonSerializable()
class ServerProduct {
  final String? productId;
  final double? price;
  final SubscriptionPlan? subscriptionPlan;

  factory ServerProduct.fromJson(Map<String, dynamic> json) => _$ServerProductFromJson(json);

  const ServerProduct({this.productId, this.price, this.subscriptionPlan});

  Map<String, dynamic> toJson() => _$ServerProductToJson(this);
}
