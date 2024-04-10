import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_review_body.g.dart';

@JsonSerializable()
class GoalReviewBody {
  final int id;
  final int difficulty;
  final bool isTryAgain;

  const GoalReviewBody({required this.id, required this.difficulty, required this.isTryAgain});

  factory GoalReviewBody.fromJson(Map<String, dynamic> json) => _$GoalReviewBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GoalReviewBodyToJson(this);
}
