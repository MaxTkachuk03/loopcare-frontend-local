import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';

part 'river_module_item_state_data.g.dart';

@immutable
@JsonSerializable()
class RiverModuleItemStateData {
  final RiverModuleItemState? itemState;
  final RiverModuleItemState prevItemState;
  final int? completedInModuleId;

  const RiverModuleItemStateData({
    required this.itemState,
    required this.prevItemState,
    required this.completedInModuleId,
  });

  static RiverModuleItemStateData fromJson(Map<String, dynamic> json) =>
      _$RiverModuleItemStateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RiverModuleItemStateDataToJson(this);

  @override
  String toString() {
    return 'itemState: $itemState, prevItemState: $prevItemState, completedInModuleId: $completedInModuleId';
  }
}
