import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_avatar_response.g.dart';

@immutable
@JsonSerializable()
class UploadAvatarResponse {
  final String data;

  const UploadAvatarResponse(this.data);

  static UploadAvatarResponse fromJson(Map<String, dynamic> json) =>
      _$UploadAvatarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadAvatarResponseToJson(this);
}
