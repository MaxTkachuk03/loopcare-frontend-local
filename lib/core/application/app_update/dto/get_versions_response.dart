import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_versions_response.g.dart';

@immutable
@JsonSerializable()
class GetVersionsResponse {
  final bool isEnabled;
  final int androidMinVersion;
  final int iosMinVersion;

  const GetVersionsResponse({
    required this.isEnabled,
    required this.androidMinVersion,
    required this.iosMinVersion,
  });

  static GetVersionsResponse fromJson(Map<String, dynamic> json) => _$GetVersionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVersionsResponseToJson(this);
}
