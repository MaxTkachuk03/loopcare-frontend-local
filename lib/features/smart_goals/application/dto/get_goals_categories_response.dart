import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

part 'get_goals_categories_response.g.dart';

@immutable
@JsonSerializable()
class GetGoalsCategoriesResponse {
  final List<SmartGoalCategory> data;

  const GetGoalsCategoriesResponse({required this.data});

  static GetGoalsCategoriesResponse fromJson(Map<String, dynamic> json) =>
      _$GetGoalsCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoalsCategoriesResponseToJson(this);
}
