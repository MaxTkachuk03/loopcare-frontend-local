import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_data.g.dart';

@immutable
@JsonSerializable()
class DeviceData {
  final String uid;
  final String platform;

  const DeviceData({required this.uid, required this.platform});

  factory DeviceData.fromJson(Map<String, dynamic> json) => _$DeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDataToJson(this);
}
