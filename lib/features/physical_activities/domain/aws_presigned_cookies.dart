import 'package:freezed_annotation/freezed_annotation.dart';

part 'aws_presigned_cookies.freezed.dart';

part 'aws_presigned_cookies.g.dart';

@freezed
abstract class AwsPresignedCookies implements _$AwsPresignedCookies {
  const AwsPresignedCookies._();

  const factory AwsPresignedCookies({
    @JsonKey(name: 'CloudFront-Policy') required String cloudFrontPolicy,
    @JsonKey(name: 'CloudFront-Key-Pair-Id') required String cloudFrontKeyPairId,
    @JsonKey(name: 'CloudFront-Signature') required String cloudFrontSignature,
  }) = _AwsPresignedCookies;

  factory AwsPresignedCookies.fromJson(Map<String, dynamic> json) => _$AwsPresignedCookiesFromJson(json);
}
