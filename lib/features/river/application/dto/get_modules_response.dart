import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';

part 'get_modules_response.g.dart';

@immutable
@JsonSerializable()
class GetModulesResponse {
  final List<RiverModule> data;

  const GetModulesResponse({required this.data});

  static GetModulesResponse fromJson(Map<String, dynamic> json) =>
      _$GetModulesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetModulesResponseToJson(this);
}
