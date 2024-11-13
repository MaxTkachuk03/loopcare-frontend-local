import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/content_ordering_item.dart';

part 'ordering_content.freezed.dart';
part 'ordering_content.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class OrderingContent with _$OrderingContent {
  const OrderingContent._();

  const factory OrderingContent({
    required String question,
    required String topLabel,
    required String bottomLabel,
    required List<ContentOrderingItem> items,
    required String feedbackCorrect,
    required String feedbackIncorrect,
    required String feedbackRevealed,
  }) = _OrderingContent;

  OrderingContent updateOrder(int oldIndex, int newIndex) {
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    return copyWith(items: items);
  }

  factory OrderingContent.fromJson(Map<String, dynamic> json) => _$OrderingContentFromJson(json);
}
