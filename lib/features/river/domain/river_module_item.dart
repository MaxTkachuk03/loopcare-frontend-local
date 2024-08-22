import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_icon_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_actions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_view_state.dart';
import 'package:loopcare_frontend/features/river/domain/feature_placement.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

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
    @Default([])
    @UnlockedFeatureTypeListConverter()
    List<UnlockedFeatureType> unlocksFeature,
    @Default(null) int? unlocksReflectionId,
    @Default(null) int? unlocksSmartGoalCategoryId,
    @Default(false) bool crossModule,
    @Default([]) List<RiverModuleItemActions> actions,
    required FeaturePlacement? featurePlacement,
    @RiverModuleItemViewStateConverter()
    required RiverModuleItemViewState states,
    @Default(null) int? completedInModuleId,
    @Default(0) int spawnedInModuleId,
  }) = _RiverModuleItem;

  Color get bgColor => states.prevItemState.bgColor(streamType);

  Color get iconColor => states.prevItemState.iconColor(streamType);

  IconData get icon => iconType.icon;

  double get iconElevation => states.prevItemState.elevation;

  bool get isProfile => iconType == RiverIconType.profile;

  bool get isPractice => iconType == RiverIconType.practise;

  bool get isCompletedCrossModule => crossModule && states.prevItemState.isCompleted;

  bool get isReadCrossModule =>
      crossModule && states.prevItemState.isRead && states.itemState.isRead;

  bool get isBuddyCrossModuleItem => crossModule && unlocksFeature.contains(UnlockedFeatureType.buddy);

  bool get isGroupingCrossModuleItem => crossModule && unlocksFeature.contains(UnlockedFeatureType.grouping);

  bool get isAdditionalBuddyCrossModuleItem => crossModule && unlocksFeature.isEmpty && actions.isEmpty;

      factory RiverModuleItem.fromJson(Map<String, dynamic> json) => _$RiverModuleItemFromJson(json);
}

class UnlockedFeatureTypeListConverter
    implements JsonConverter<List<UnlockedFeatureType>, List<dynamic>> {
  const UnlockedFeatureTypeListConverter();

  @override
  List<UnlockedFeatureType> fromJson(List<dynamic> json) {
    return json
        .map((value) {
          UnlockedFeatureType? enumValue;
          try {
            enumValue = UnlockedFeatureType.values.byName(value as String);
          } catch (e) {
            enumValue = null;
          }
          return enumValue;
        })
        .whereType<UnlockedFeatureType>()
        .toList(); // Remove null values
  }

  @override
  List<dynamic> toJson(List<UnlockedFeatureType> object) => object.map((e) => e.name).toList();
}
