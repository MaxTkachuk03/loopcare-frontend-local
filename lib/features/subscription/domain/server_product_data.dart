import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product.dart';

part 'server_product_data.freezed.dart';
part 'server_product_data.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ServerProductData with _$ServerProductData {
  const factory ServerProductData({
    @Default([]) List<ServerProduct> data,
  }) = _ServerProductData;

  factory ServerProductData.fromJson(Map<String, dynamic> json) =>
      _$ServerProductDataFromJson(json);
}
