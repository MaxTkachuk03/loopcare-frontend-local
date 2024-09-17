import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/content_feedback.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/content_ordering_item.dart';

part 'ordering_content.freezed.dart';
part 'ordering_content.g.dart';

@freezed
class OrderingContent with _$OrderingContent {
  const factory OrderingContent({
    required String question,
    required String topLabel,
    required String bottomLabel,
    required List<ContentOrderingItem> items,
    required List<String> correctOrder,
    required List<ContentFeedback> feedback,
  }) = _OrderingContent;

  factory OrderingContent.fromJson(Map<String, dynamic> json) => _$OrderingContentFromJson(json);
}
