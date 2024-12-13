import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_state.dart';

part 'river_module_state_data.g.dart';

@immutable
@JsonSerializable()
class RiverModuleStateData {
  final RiverModuleState moduleState;

  const RiverModuleStateData({required this.moduleState});

  static RiverModuleStateData fromJson(Map<String, dynamic> json) =>
      _$RiverModuleStateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RiverModuleStateDataToJson(this);
}
