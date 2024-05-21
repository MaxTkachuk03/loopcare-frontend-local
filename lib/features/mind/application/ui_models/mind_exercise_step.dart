import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_explanation_type.dart';

@immutable
class MindExerciseStep extends MindContent {
  final String? lowestText;
  final String? highestText;

  const MindExerciseStep({
    required super.src,
    required super.type,
    super.orientation,
    super.duration,
    this.lowestText,
    this.highestText,
  });

  const MindExerciseStep.rating({
    required super.src,
    super.orientation,
    super.duration,
    super.type = TechniqueExplanationType.rating,
    this.lowestText,
    this.highestText,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MindExerciseStep &&
          super.duration == other.duration &&
          super.orientation == other.orientation &&
          super.src == other.src &&
          super.type == other.type &&
          runtimeType == other.runtimeType &&
          lowestText == other.lowestText &&
          highestText == other.highestText;

  @override
  int get hashCode =>
      super.duration.hashCode ^
      super.orientation.hashCode ^
      super.src.hashCode ^
      super.type.hashCode ^
      lowestText.hashCode ^
      highestText.hashCode;
}

extension MindContentUpcast on MindContent {
  MindExerciseStep toStep({
    String? lowestText,
    String? highestText,
  }) => MindExerciseStep(
          type: type,
          src: src,
          duration: duration,
          orientation: orientation,
          highestText: highestText,
          lowestText: lowestText,
        );
}