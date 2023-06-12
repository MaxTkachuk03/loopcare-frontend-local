import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

part 'account.freezed.dart';

part 'account.g.dart';

@freezed
abstract class Account implements _$Account {
  const Account._();

  const factory Account({
    required int id,
    required String name,
    required String email,
    required String? country,
    required bool isPreferencesComplete,
    required String gender,
    required String bioGender,
    @Default(0) double height,
    @Default(0) double weight,
    @Default(0) int bmi,
    DateTime? birthDate,
    @Default('') String diabetes,
    @Default([]) List<FoodPreference>? foodPreferencesHates,
    @Default([]) List<FoodPreference>? foodPreferencesDislikes,
    @Default([]) List<FoodPreference>? foodPreferencesAllergic,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
