import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/subscription_plan.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

part 'subscription.freezed.dart';

part 'subscription.g.dart';

@freezed
abstract class Subscription implements _$Subscription {
  const Subscription._();

  const factory Subscription({
    @Default(0) int id,
    @Default('2023-10-13T10:28:20.536Z') String expiresAt,
    @Default('2023-09-12T10:28:20.536Z') String createdAt,
    @Default(false) bool isActive,
    @Default('ios') String vendor,
    @Default('common') String state,
    @Default(SubscriptionPlan())  SubscriptionPlan  subscriptionPlan,
  }) = _Subscription;


  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
