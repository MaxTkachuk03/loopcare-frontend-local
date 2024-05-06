import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/bmr/dto/bmr_item.dart';

part 'get_bmr_response.g.dart';

@immutable
@JsonSerializable()
class GetBmrResponse {
  final BmrItem data;

  const GetBmrResponse({required this.data});

  static GetBmrResponse fromJson(Map<String, dynamic> json) => _$GetBmrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBmrResponseToJson(this);
}
