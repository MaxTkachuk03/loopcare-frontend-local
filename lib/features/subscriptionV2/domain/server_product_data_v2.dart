import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/server_product_v2.dart';

part 'server_product_data_v2.freezed.dart';
part 'server_product_data_v2.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ServerProductDataV2 with _$ServerProductDataV2 {
  const factory ServerProductDataV2({
    @Default([]) List<ServerProductV2> data,
  }) = _ServerProductDataV2;

  factory ServerProductDataV2.fromJson(Map<String, dynamic> json) =>
      _$ServerProductDataV2FromJson(json);
}
