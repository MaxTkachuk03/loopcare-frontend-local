import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/content_ordering_item.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

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

  factory OrderingContent.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing _OrderingContent: $json');

      final question = json['question'] as String? ?? '';
      log.d('Parsed question: $question');

      final topLabel = (json['highestText'] as String?) ?? '';
      log.d('Parsed topLabel: $topLabel');

      final bottomLabel = (json['lowestText'] as String?) ?? '';
      log.d('Parsed bottomLabel: $bottomLabel');

      final items = (json['answers'] as List<dynamic>)
          .map((e) => ContentOrderingItem.debugFromJson(e as Map<String, dynamic>))
          .toList();
      log.d('Parsed items: $items');

      final feedbackCorrect = json['feedbackCorrect'] as String;
      log.d('Parsed feedbackCorrect: $feedbackCorrect');

      final feedbackIncorrect = json['feedbackIncorrect'] as String;
      log.d('Parsed feedbackIncorrect: $feedbackIncorrect');

      final feedbackRevealed = (json['feedbackRevealed'] as String?) ?? '';
      log.d('Parsed feedbackRevealed: $feedbackRevealed');

      return _OrderingContent(
        question: question,
        topLabel: topLabel,
        bottomLabel: bottomLabel,
        items: items,
        feedbackCorrect: feedbackCorrect,
        feedbackIncorrect: feedbackIncorrect,
        feedbackRevealed: feedbackRevealed,
      );
    } catch (e, stackTrace) {
      log.e('Error in _OrderingContent.debugFromJson: $e', error: e, stackTrace: stackTrace);
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
