import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_prefs_data.g.dart';

@immutable
@JsonSerializable()
class FoodPrefsData {
  final IList<int> hates;
  final IList<int> allergic;
  final IList<int> dislike;
  final int? period;

  const FoodPrefsData({
    required this.hates,
    required this.allergic,
    required this.dislike,
    this.period,
  });

  factory FoodPrefsData.fromJson(Map<String, dynamic> json) =>
      _$FoodPrefsDataFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPrefsDataToJson(this);
}
