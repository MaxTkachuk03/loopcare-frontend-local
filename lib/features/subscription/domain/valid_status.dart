import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'valid_status.g.dart';

@immutable
@JsonSerializable()
class ValidStatus {
  final bool? valid;

  const ValidStatus({
    this.valid,
  });

  factory ValidStatus.fromJson(Map<String, dynamic> json) => _$ValidStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ValidStatusToJson(this);
}
