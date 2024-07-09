import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

part 'river_module_item.freezed.dart';

part 'river_module_item.g.dart';

@freezed
class RiverModuleItem with _$RiverModuleItem {
  const RiverModuleItem._();

  const factory RiverModuleItem({
    @Default(0) int id,
    required RiverModuleStreamType streamType,
    required RiverIconType iconType,
    @Default(0) int lessonId,
    @Default(false) bool isRootItem,
    @Default([]) List<int> unlocksItems,
    @Default([]) List<UnlockedFeatureType> unlocksFeature,
    @Default(null) int? unlocksAssignmentId,
    @Default(null) int? unlocksSmartGoalCategoryId,
    @Default(false) bool crossModule,
    required FeaturePlacement? featurePlacement,
    required RiverModuleItemState itemState,
  }) = _RiverModuleItem;

  Color get bgColor => itemState.bgColor(streamType);

  IconData get icon => iconType.icon;

  Color get iconColor => itemState.iconColor(streamType);

  double get iconElevation => itemState.elevation;

  bool get isLocked => itemState.isLocked;

  bool get isUnLocked => itemState.isUnLocked;

  bool get isCompleted => itemState.isCompleted;

  bool get isRead => itemState.isRead;

  bool get isProfile => iconType == RiverIconType.profile;

  bool get isPractice => iconType == RiverIconType.practise;

  factory RiverModuleItem.fromJson(Map<String, dynamic> json) => _$RiverModuleItemFromJson(json);
}
