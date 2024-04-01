import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_goal.freezed.dart';
part 'smart_goal.g.dart';

// TODO update with needed fields
@freezed
class SmartGoal with _$SmartGoal {
  const SmartGoal._();

  const factory SmartGoal({
    required int id,
    required String name,
  }) = _SmartGoal;

  factory SmartGoal.fromJson(Map<String, dynamic> json) => _$SmartGoalFromJson(json);
}
