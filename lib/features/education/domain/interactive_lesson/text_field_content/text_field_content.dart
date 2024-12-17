import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_content.freezed.dart';

part 'text_field_content.g.dart';

@freezed
class TextFieldContent with _$TextFieldContent {
  const factory TextFieldContent({
    required String question,
    String? subtext,
    int? maxCharsLength,
    int? maxTextFieldsAmount,
    int? minTextFieldsAmount,
  }) = _TextFieldContent;

  factory TextFieldContent.fromJson(Map<String, dynamic> json) => _$TextFieldContentFromJson(json);

  factory TextFieldContent.empty() => const TextFieldContent(
        question: '',
        subtext: null,
        maxCharsLength: null,
        maxTextFieldsAmount: null,
        minTextFieldsAmount: null,
      );
}
