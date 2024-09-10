import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';

part 'search_response.g.dart';

@immutable
@JsonSerializable()
class SearchResponse {
  final List<SearchItem> data;

  const SearchResponse(this.data);

  static SearchResponse fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
