import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

part 'mood.freezed.dart';

part 'mood.g.dart';

@freezed
class Mood with _$Mood {
  const Mood._();

  const factory Mood({
    @Default(0) int id,
    @Default(1) int scale,
    @Default([]) List<String> emotion,
    @Default([]) List<String> person,
    @Default([]) List<String> location,
    @Default([]) List<String> food,
    @Default('') String note,
    required DateTime time,
    required DateTime loggingDate,
  }) = _Mood;

  String get dashboardTime => time.toLocal().timeHoursMinutes12;

  factory Mood.fromJson(Map<String, dynamic> json) => _$MoodFromJson(json);
}
