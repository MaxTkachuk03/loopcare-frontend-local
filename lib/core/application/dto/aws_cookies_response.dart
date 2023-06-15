import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/aws_presigned_cookies.dart';

part 'aws_cookies_response.g.dart';

@immutable
@JsonSerializable()
class AwsCookiesResponse {
  final AwsPresignedCookies data;

  const AwsCookiesResponse({
    required this.data,
  });

  static AwsCookiesResponse fromJson(Map<String, dynamic> json) => _$AwsCookiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AwsCookiesResponseToJson(this);
}
