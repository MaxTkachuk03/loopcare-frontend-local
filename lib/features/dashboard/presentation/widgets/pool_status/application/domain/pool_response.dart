import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'module_item.dart';

part 'pool_response.g.dart';

@immutable
@JsonSerializable()
class PoolResponse {
  final List<ModuleItem>? moduleItems;
  final bool isCompleted;
  final String? moduleState;
  final int? id;
  final String? title;
  final int? nextModuleUnlockDelay;
  final String? nextModuleUnlocksAt;

  const PoolResponse({
    required this.moduleItems,
    required this.isCompleted,
    required this.moduleState,
    required this.id,
    required this.title,
    required this.nextModuleUnlockDelay,
    this.nextModuleUnlocksAt,
  });

  factory PoolResponse.fromJson(Map<String, dynamic> json) => _$PoolResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PoolResponseToJson(this);
}
