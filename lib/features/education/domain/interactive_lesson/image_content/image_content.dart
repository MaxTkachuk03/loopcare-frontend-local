import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_content.freezed.dart';
part 'image_content.g.dart';

@freezed
class ImageContent with _$ImageContent {
  const factory ImageContent({
    required String src,
  }) = _ImageContent;

  factory ImageContent.fromJson(Map<String, dynamic> json) => _$ImageContentFromJson(json);
}
