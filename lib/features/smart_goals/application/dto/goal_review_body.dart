import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_review_body.g.dart';

@JsonSerializable()
class GoalReviewBody {
  final int id;
  final int difficulty;
  final bool isTryAgain;
  final String categoryTitle;
  final String goalTitle;

  const GoalReviewBody({
    required this.id,
    required this.categoryTitle,
    required this.goalTitle,
    required this.difficulty,
    required this.isTryAgain,
  });

  factory GoalReviewBody.fromJson(Map<String, dynamic> json) => _$GoalReviewBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GoalReviewBodyToJson(this);
}
