import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_goal_category.freezed.dart';
part 'smart_goal_category.g.dart';

@freezed
class SmartGoalCategory with _$SmartGoalCategory {
  const SmartGoalCategory._();

  const factory SmartGoalCategory({
    required int id,
    required String externalId,
    @Default('') String image,
    @Default('') String name,
    @Default(false) bool isUnlocked,
    @Default(false) bool isNew,
  }) = _SmartGoalCategory;

  factory SmartGoalCategory.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalCategoryFromJson(json);
}
