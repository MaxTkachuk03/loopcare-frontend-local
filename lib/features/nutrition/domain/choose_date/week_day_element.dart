import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_day_element.freezed.dart';

part 'week_day_element.g.dart';

@freezed
abstract class WeekDayElement implements _$WeekDayElement {
  const WeekDayElement._();

  const factory WeekDayElement({
    required DateTime date,
    required String name,
    required int day,
    required String month,
    required bool enabled,
    required bool filled,
    required bool selected,
  }) = _WeekDayElement;

  factory WeekDayElement.fromJson(Map<String, dynamic> json) => _$WeekDayElementFromJson(json);
}
