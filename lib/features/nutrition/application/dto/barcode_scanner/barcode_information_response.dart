import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/food_item.dart';

part 'barcode_information_response.g.dart';

@immutable
@JsonSerializable()
class BarcodeInformationResponse {
  final FoodItem data;

  const BarcodeInformationResponse(this.data);

  static BarcodeInformationResponse fromJson(Map<String, dynamic> json) =>
      _$BarcodeInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeInformationResponseToJson(this);
}
