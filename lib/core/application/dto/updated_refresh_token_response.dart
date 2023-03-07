import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'updated_refresh_token_response.g.dart';

@immutable
@JsonSerializable()
class UpdatedRefreshTokenResponse {
  final String refreshToken;

  const UpdatedRefreshTokenResponse(this.refreshToken);

  static UpdatedRefreshTokenResponse fromJson(Map<String, dynamic> json) =>
      _$UpdatedRefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedRefreshTokenResponseToJson(this);
}
