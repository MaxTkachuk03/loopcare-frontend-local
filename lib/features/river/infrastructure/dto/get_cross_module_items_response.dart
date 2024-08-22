import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

part 'get_cross_module_items_response.g.dart';

@immutable
@JsonSerializable()
class GetCrossModuleItemsResponse {
  final List<RiverModuleItem> data;

  const GetCrossModuleItemsResponse({required this.data});

  static GetCrossModuleItemsResponse fromJson(Map<String, dynamic> json) =>
      _$GetCrossModuleItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCrossModuleItemsResponseToJson(this);
}
