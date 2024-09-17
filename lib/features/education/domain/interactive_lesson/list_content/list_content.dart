import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/list_content/content_list_item.dart';

part 'list_content.freezed.dart';
part 'list_content.g.dart';

@freezed
class ListContent with _$ListContent {
  const factory ListContent({
    required List<ContentListItem> items,
  }) = _ListContent;

  factory ListContent.fromJson(Map<String, dynamic> json) => _$ListContentFromJson(json);
}
