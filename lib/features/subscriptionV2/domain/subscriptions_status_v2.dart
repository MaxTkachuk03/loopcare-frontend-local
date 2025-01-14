enum SubscriptionStatusV2 { trialPeriod, common, gracePeriod, cancelled, ended, refunded, non }

extension SubscriptionStatusUtil on SubscriptionStatusV2 {
  bool get isTrialPeriod => this == SubscriptionStatusV2.trialPeriod;

  bool get isCommon => this == SubscriptionStatusV2.common;

  bool get isGracePeriod => this == SubscriptionStatusV2.gracePeriod;

  bool get isCancelled => this == SubscriptionStatusV2.cancelled;

  bool get isEnded => this == SubscriptionStatusV2.ended;

  bool get isRefunded => this == SubscriptionStatusV2.refunded;

  static SubscriptionStatusV2 parse(String? value) {
    switch (value) {
      case 'trialPeriod':
        return SubscriptionStatusV2.trialPeriod;
      case 'ended':
        return SubscriptionStatusV2.ended;
      case 'common':
        return SubscriptionStatusV2.common;
      case 'gracePeriod':
        return SubscriptionStatusV2.gracePeriod;
      case 'cancelled':
        return SubscriptionStatusV2.cancelled;
      case 'refunded':
        return SubscriptionStatusV2.refunded;
      default:
        return SubscriptionStatusV2.non;
    }
  }
}
