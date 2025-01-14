import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchasable_product_v2.freezed.dart';
part 'purchasable_product_v2.g.dart';

@freezed
class PurchasableProductV2 with _$PurchasableProductV2 {
  factory PurchasableProductV2({
    required List<PurchasablePlan> plans,
  }) = _PurchasableProductV2;

  factory PurchasableProductV2.fromJson(Map<String, dynamic> json) =>
      _$PurchasableProductV2FromJson(json);
}

@freezed
class PurchasablePlan with _$PurchasablePlan {
  factory PurchasablePlan({
    required String id,
    required String title,
    required String description,
    required String price,
    required double rawPrice,
    required String currencyCode,
    required String currencySymbol,
    required int subscriptionIndex,
  }) = _PurchasablePlan;

  factory PurchasablePlan.fromJson(Map<String, dynamic> json) => _$PurchasablePlanFromJson(json);
}
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'purchasable_product_v2.freezed.dart';
// part 'purchasable_product_v2.g.dart';
//
// @freezed
// class PurchasableProductV2 with _$PurchasableProductV2 {
//   factory PurchasableProductV2({
//     required List<PurchasablePlan> plans,
//   }) = _PurchasableProductV2;
//
//   factory PurchasableProductV2.fromJson(Map<String, dynamic> json) =>
//       _$PurchasableProductV2FromJson(json);
// }
//
// @freezed
// class PurchasablePlan with _$PurchasablePlan {
//   factory PurchasablePlan({
//     required String id,
//     required String title,
//     required String description,
//     required String price,
//     required double rawPrice,
//     required String currencyCode,
//     required String currencySymbol,
//     required int subscriptionIndex,
//   }) = _PurchasablePlan;
//
//   factory PurchasablePlan.fromJson(Map<String, dynamic> json) => _$PurchasablePlanFromJson(json);
// }
