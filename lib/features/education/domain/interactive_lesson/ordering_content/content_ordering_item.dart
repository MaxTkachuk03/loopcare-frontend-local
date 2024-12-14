import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'content_ordering_item.freezed.dart';
part 'content_ordering_item.g.dart';

@freezed
class ContentOrderingItem with _$ContentOrderingItem {
  const factory ContentOrderingItem({
    required int id,
    required int order,
    required String src,
    required String title,
    required String description,
  }) = _ContentOrderingItem;

  factory ContentOrderingItem.fromJson(Map<String, dynamic> json) =>
      _$ContentOrderingItemFromJson(json);

  factory ContentOrderingItem.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing ContentOrderingItem: $json');

      final id = json['externalId'] as int;
      log.d('Parsed id: $id');

      final order = json['order'] as int;
      log.d('Parsed order: $order');

      final src = (json['imageURL'] as String?) ?? '';
      log.d('Parsed src: $src');

      final title = (json['label'] as String?) ?? '';
      log.d('Parsed title: $title');

      final description = (json['description'] as String?) ?? '';
      log.d('Parsed description: $description');

      return ContentOrderingItem(
        id: id,
        order: order,
        src: src,
        title: title,
        description: description,
      );
    } catch (e, stackTrace) {
      log.e('Error in ContentOrderingItem.debugFromJson: $e', error: e, stackTrace: stackTrace);
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
