import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'valid_status_v2.g.dart';

@immutable
@JsonSerializable()
class ValidStatusV2 {
  final bool? valid;

  const ValidStatusV2({
    this.valid,
  });

  factory ValidStatusV2.fromJson(Map<String, dynamic> json) => _$ValidStatusV2FromJson(json);

  Map<String, dynamic> toJson() => _$ValidStatusV2ToJson(this);
}
