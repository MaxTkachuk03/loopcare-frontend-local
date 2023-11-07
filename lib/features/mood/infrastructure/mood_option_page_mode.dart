import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_option_page_mode.freezed.dart';

@freezed
class MoodOptionPageMode with _$MoodOptionPageMode {
  const factory MoodOptionPageMode.emotion() = MoodOptionPageModeEmotion;

  const factory MoodOptionPageMode.time() = MoodOptionPageModeTime;

  const factory MoodOptionPageMode.withWho() = MoodOptionPageModeWithWho;

  const factory MoodOptionPageMode.where() = MoodOptionPageModeWhere;

  const factory MoodOptionPageMode.food() = MoodOptionPageModeFood;
}
