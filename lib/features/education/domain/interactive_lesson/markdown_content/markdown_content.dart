import 'package:freezed_annotation/freezed_annotation.dart';

part 'markdown_content.freezed.dart';
part 'markdown_content.g.dart';

@freezed
class MarkdownContent with _$MarkdownContent {
  const factory MarkdownContent({
    required String markdown,
  }) = _MarkdownContent;

  factory MarkdownContent.fromJson(Map<String, dynamic> json) => _$MarkdownContentFromJson(json);
}
