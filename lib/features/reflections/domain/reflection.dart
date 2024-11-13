import 'package:flutter_animate/flutter_animate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

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
    required RiverModuleStreamType riverStreamType,
    required List<ReflectionQuestion> questions,
  }) = _Reflection;

  bool get isComplete => completedAt != null;

  DateTime get unlockedDate => unlockedAt ?? DateTime.now();

  bool get isCompletedMoreThanWeekAgo =>
      !isComplete && (unlockedAt?.isBefore(DateTime.now().add(7.days)) ?? false);

  factory Reflection.fromJson(Map<String, dynamic> json) => _$ReflectionFromJson(json);
}
