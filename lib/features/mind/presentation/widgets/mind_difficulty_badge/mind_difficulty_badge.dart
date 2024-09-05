import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_exercise_difficulty.dart';

class MindDifficultyBadge extends StatelessWidget {
  const MindDifficultyBadge(this.difficulty, {super.key});

  final TechniqueExerciseDifficulty? difficulty;

  @override
  Widget build(BuildContext context) => switch(difficulty) {
    TechniqueExerciseDifficulty.easy => CategoryLabel.difficultyEasy(),
    TechniqueExerciseDifficulty.medium => CategoryLabel.difficultyMedium(),
    TechniqueExerciseDifficulty.hard => CategoryLabel.difficultyHard(),
    _ => const SizedBox.shrink(),
  };
}
