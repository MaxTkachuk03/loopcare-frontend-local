import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription_plan.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_state.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
class Subscription with _$Subscription {
  const Subscription._();

  const factory Subscription({
    int? id,
    String? expiresAt,
    String? purchasedAt,
    String? serverDate,
    double? price,
    @Default(false) bool isActive,
    String? vendor,
    SubscriptionStatus? state,
    String? productId,
    SubscriptionPlan? subscriptionPlan,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

//Todo discuss  with backend team -> return localization subscription type
  String get subscriptionType => switch (productId ?? '') {
        'daily' => LocalizedTexts.subscriptionDaily.tr(),
        'testDaily' => LocalizedTexts.subscriptionDaily.tr(),
        'weekly' => LocalizedTexts.subscriptionWeekly.tr(),
        'monthly' => LocalizedTexts.subscriptionMonth.tr(),
        'quarterly' => LocalizedTexts.subscriptionQuarterly.tr(),
        'annual' => LocalizedTexts.subscriptionAnnually.tr(),
        _ => ''
      };
}
