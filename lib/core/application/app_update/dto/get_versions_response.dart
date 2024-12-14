import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_versions_response.g.dart';

@immutable
@JsonSerializable()
class GetVersionsResponse {
  final bool isEnabled;
  final bool isForceUpdate;
  final int androidMinVersion;
  final int iosMinVersion;
  final int termsAndConditionsVersion;
  final int privacyPolicyVersion;

  const GetVersionsResponse({
    required this.isEnabled,
    required this.androidMinVersion,
    required this.iosMinVersion,
    this.isForceUpdate = true,
    this.termsAndConditionsVersion = 1,
    this.privacyPolicyVersion = 1,
  });

  static GetVersionsResponse fromJson(Map<String, dynamic> json) =>
      _$GetVersionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVersionsResponseToJson(this);
}
