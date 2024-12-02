import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_timing_content.freezed.dart';
part 'meal_timing_content.g.dart';

@freezed
class MealTimingContent with _$MealTimingContent {
  const factory MealTimingContent({
    required String markdown,
  }) = _MealTimingContent;

  factory MealTimingContent.fromJson(Map<String, dynamic> json) => _$MealTimingContentFromJson(json);
}
