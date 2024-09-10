// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aws_presigned_cookies.freezed.dart';

part 'aws_presigned_cookies.g.dart';

@freezed
abstract class AwsPresignedCookies implements _$AwsPresignedCookies {
  const AwsPresignedCookies._();

  const factory AwsPresignedCookies({
    @Default('') @JsonKey(name: 'CloudFront-Policy') String cloudFrontPolicy,
    @Default('') @JsonKey(name: 'CloudFront-Key-Pair-Id') String cloudFrontKeyPairId,
    @Default('') @JsonKey(name: 'CloudFront-Signature') String cloudFrontSignature,
  }) = _AwsPresignedCookies;

  factory AwsPresignedCookies.fromJson(Map<String, dynamic> json) =>
      _$AwsPresignedCookiesFromJson(json);
}
