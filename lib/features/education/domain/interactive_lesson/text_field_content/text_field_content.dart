import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_content.freezed.dart';

part 'text_field_content.g.dart';

@freezed
class TextFieldContent with _$TextFieldContent {
  const factory TextFieldContent({
    required String question,
    String? subtext,
  }) = _TextFieldContent;

  factory TextFieldContent.fromJson(Map<String, dynamic> json) => _$TextFieldContentFromJson(json);
}
