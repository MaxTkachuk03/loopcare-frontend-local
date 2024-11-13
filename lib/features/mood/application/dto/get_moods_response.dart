import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';

part 'get_moods_response.g.dart';

@immutable
@JsonSerializable()
class GetMoodsResponse {
  final List<Mood> data;

  const GetMoodsResponse({required this.data});

  static GetMoodsResponse fromJson(Map<String, dynamic> json) => _$GetMoodsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMoodsResponseToJson(this);
}
