// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/subscription/donain/server_product.dart';

part 'list_server_product.freezed.dart';
part 'list_server_product.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ListServerProduct with _$ListServerProduct {
  const factory ListServerProduct({
    @Default([]) List<ServerProduct> data,
  }) = _ListServerProduct;

  factory ListServerProduct.fromJson(Map<String, dynamic> json) => _$ListServerProductFromJson(json);
}
