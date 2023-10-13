enum SubscriptionStatus { trialPeriod, common, gracePeriod, cancelled, ended, non }


extension SubscriptionStatusUtil on SubscriptionStatus {
  bool get isTrialPeriod => this == SubscriptionStatus.trialPeriod;

  bool get isCommon => this == SubscriptionStatus.common;

  bool get isGracePeriod => this == SubscriptionStatus.gracePeriod;

  bool get isCancelled => this == SubscriptionStatus.cancelled;

  bool get isEnded => this == SubscriptionStatus.ended;

  static SubscriptionStatus parse(String? value) {
    switch (value) {
      case 'trialPeriod':
        return SubscriptionStatus.trialPeriod;
      case 'ended':
        return SubscriptionStatus.ended;
      case 'common':
        return SubscriptionStatus.common;
      case 'gracePeriod':
        return SubscriptionStatus.gracePeriod;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      default:
        return SubscriptionStatus.non;
    }
  }

}
