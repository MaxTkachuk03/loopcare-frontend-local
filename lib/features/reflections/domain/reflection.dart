import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';

part 'reflection.freezed.dart';

part 'reflection.g.dart';

@freezed
class Reflection with _$Reflection {
  const Reflection._();

  const factory Reflection({
    required int id,
    required String title,
    required String image,
    required String instruction,
    required DateTime? completedAt,
    required DateTime? unlockedAt,
    required int lessonId,
    required List<ReflectionQuestion> questions,
  }) = _Reflection;

  bool get isComplete => completedAt != null;

  DateTime get unlockedDate => unlockedAt ?? DateTime.now();

  factory Reflection.fromJson(Map<String, dynamic> json) => _$ReflectionFromJson(json);
}
