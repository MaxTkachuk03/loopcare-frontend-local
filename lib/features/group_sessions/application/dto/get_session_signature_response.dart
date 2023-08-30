import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_session_signature_response.g.dart';

@immutable
@JsonSerializable()
class GetSessionSignatureResponse {
  final String signature;

  const GetSessionSignatureResponse({
    required this.signature,
  });

  static GetSessionSignatureResponse fromJson(Map<String, dynamic> json) =>
      _$GetSessionSignatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSessionSignatureResponseToJson(this);
}
