import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

part 'subscription_plan.freezed.dart';

part 'subscription_plan.g.dart';

@freezed
abstract class SubscriptionPlan implements _$SubscriptionPlan {
  const SubscriptionPlan._();

  const factory SubscriptionPlan({
    @Default(0) int id,
    @Default('Monthly') String title,
    @Default('Monthly subscription') String description,
    @Default(1) double price,
  }) = _SubscriptionPlan;


  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);
}
