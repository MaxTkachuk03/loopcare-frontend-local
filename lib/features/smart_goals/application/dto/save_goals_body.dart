import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_goals_body.g.dart';

@JsonSerializable()
class SaveGoalsBody {
  final int smartGoalId;

  const SaveGoalsBody({required this.smartGoalId});

  factory SaveGoalsBody.fromJson(Map<String, dynamic> json) => _$SaveGoalsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveGoalsBodyToJson(this);
}
