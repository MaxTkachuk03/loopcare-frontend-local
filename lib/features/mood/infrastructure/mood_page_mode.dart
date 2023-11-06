import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';

part 'mood_page_mode.freezed.dart';

@freezed
class MoodPageMode with _$MoodPageMode {
  const factory MoodPageMode.create() = MoodPageModeCreate;

  const factory MoodPageMode.edit({required Mood moodRecord}) = MoodPageModeEdit;
}
