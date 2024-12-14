import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'updated_access_token_response.g.dart';

@immutable
@JsonSerializable()
class UpdatedAccessTokenResponse {
  final String accessToken;

  const UpdatedAccessTokenResponse(this.accessToken);

  static UpdatedAccessTokenResponse fromJson(Map<String, dynamic> json) =>
      _$UpdatedAccessTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedAccessTokenResponseToJson(this);
}
