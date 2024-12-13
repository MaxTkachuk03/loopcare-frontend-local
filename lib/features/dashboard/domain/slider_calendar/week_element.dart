import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_element.freezed.dart';

part 'week_element.g.dart';

@freezed
abstract class WeekElement implements _$WeekElement {
  const WeekElement._();

  const factory WeekElement({
    required DateTime startDate,
    required DateTime endDate,
    required int weekNumber,
  }) = _WeekElement;

  factory WeekElement.fromJson(Map<String, dynamic> json) => _$WeekElementFromJson(json);
}
