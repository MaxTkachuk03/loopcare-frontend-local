import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/food_item_bar_code.dart';

part 'barcode_information_response.g.dart';

@immutable
@JsonSerializable()
class BarcodeInformationResponse {
  final FoodItemBarCode data;

  const BarcodeInformationResponse(this.data);

  static BarcodeInformationResponse fromJson(Map<String, dynamic> json) =>
      _$BarcodeInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeInformationResponseToJson(this);
}
