import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_bmr_response.g.dart';

@immutable
@JsonSerializable()
class GetBmrResponse {
  final String bmr;

  const GetBmrResponse({required this.bmr});

  static GetBmrResponse fromJson(Map<String, dynamic> json) => _$GetBmrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBmrResponseToJson(this);
}
