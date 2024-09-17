import 'package:freezed_annotation/freezed_annotation.dart';

part 'paragraph_content.freezed.dart';
part 'paragraph_content.g.dart';

@freezed
class ParagraphContent with _$ParagraphContent {
  const factory ParagraphContent({
    required String paragraph,
  }) = _ParagraphContent;

  factory ParagraphContent.fromJson(Map<String, dynamic> json) => _$ParagraphContentFromJson(json);
}
