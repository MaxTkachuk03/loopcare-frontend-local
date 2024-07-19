import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';

part 'river_module_item_state_data.g.dart';

@immutable
@JsonSerializable()
class RiverModuleItemStateData {
  final RiverModuleItemState itemState;

  const RiverModuleItemStateData({required this.itemState});

  static RiverModuleItemStateData fromJson(Map<String, dynamic> json) =>
      _$RiverModuleItemStateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RiverModuleItemStateDataToJson(this);
}
