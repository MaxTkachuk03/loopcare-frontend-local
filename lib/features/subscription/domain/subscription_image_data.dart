import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_image_data.g.dart';

@immutable
@JsonSerializable()
class SubscriptionImageData {
  final String? url;
  final String? label;
  final String? title;

  const SubscriptionImageData(
    this.url,
    this.label,
    this.title,
  );

  factory SubscriptionImageData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionImageDataToJson(this);
}
