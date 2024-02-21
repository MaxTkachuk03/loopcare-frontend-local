import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@immutable
@JsonSerializable()
class DeviceInfo {
  final String advertiseId;
  final String deviceId;

  const DeviceInfo({
    required this.advertiseId,
    required this.deviceId,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
