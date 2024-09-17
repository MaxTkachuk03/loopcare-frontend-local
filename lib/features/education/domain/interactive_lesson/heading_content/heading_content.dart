import 'package:freezed_annotation/freezed_annotation.dart';

part 'heading_content.freezed.dart';
part 'heading_content.g.dart';

@freezed
class HeadingContent with _$HeadingContent {
  const factory HeadingContent({
    required String title,
  }) = _HeadingContent;

  factory HeadingContent.fromJson(Map<String, dynamic> json) => _$HeadingContentFromJson(json);
}
