import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/subscription/infrastructure/subscription_access_type.dart';

class SubscriptionAccessBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const SubscriptionAccessBadge({
    super.key,
    required this.label,
    required this.color,
    this.textColor = AppColors.blueDarker,
  });

  factory SubscriptionAccessBadge.limited() => SubscriptionAccessBadge(
        label: SubscriptionAccessType.limit.label,
        color: SubscriptionAccessType.limit.regularColor,
      );

  factory SubscriptionAccessBadge.flexible() => SubscriptionAccessBadge(
        label: SubscriptionAccessType.flexible.label,
        color: SubscriptionAccessType.flexible.regularColor,
      );

  factory SubscriptionAccessBadge.lifetime() => SubscriptionAccessBadge(
        label: SubscriptionAccessType.lifetime.label,
        color: SubscriptionAccessType.lifetime.regularColor,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: color),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: CustomText.w600(
        label,
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: ThemeConstants.fontSize10,
          color: textColor,
        ),
      ),
    );
  }
}
