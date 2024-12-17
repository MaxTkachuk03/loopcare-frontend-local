import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_content_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/presentation/checked_item.dart';
import 'package:loopcare_frontend/features/subscriptionV2/presentation/saving_item.dart';
import 'package:loopcare_frontend/features/subscriptionV2/presentation/status_item.dart';

class SubscriptionPageV2Item extends StatelessWidget {
  const SubscriptionPageV2Item(
      {super.key,
      required this.status,
      required this.width,
      required this.isLimited,
      required this.index,
      required this.isChecked,
      this.onPressed,
      required this.title,
      required this.price,
      required this.savings,
      required this.contentLength,
      required this.content});

  final String status;
  final double width;
  final bool isLimited;
  final String title;
  final double price;
  final int savings;
  final int index;
  final void Function()? onPressed;
  final bool isChecked;
  final int contentLength;
  final List<SubscriptionPlanContentV2> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (status.isNotEmpty)
          StatusItem(width: width, isLimited: isLimited, status: status),
        Container(
          margin: EdgeInsets.only(bottom: isLimited ? 0 : 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: isChecked
                  ? isLimited
                      ? AppColors.limitedOfferBackground
                      : AppColors.greyDisable
                  : AppColors.white,
              borderRadius: status.isNotEmpty
                  ? const BorderRadius.vertical(bottom: Radius.circular(16.0))
                  : BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.black,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: AppColors.black,
                  offset: Offset(0, 4),
                  blurRadius: 16,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onPressed,
                icon: isChecked
                    ? const _CustomIcon()
                    : const Icon(Icons.circle_outlined),
                iconSize: 24.0,
                color: AppColors.blueRegular,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText.w700(title,
                            style: context.textTheme.bodyMedium),
                        const Spacer(),
                        CustomText.w700('\$${price.toInt()}/month',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(fontSize: 20)),
                      ],
                    ),
                    if (savings.isEven)
                      SavingItem(savings: savings, index: index),
                    const SizedBox(height: 4.0),
                    if (isChecked)
                      CheckedItem(
                        index: index,
                        contentLength: contentLength,
                        content: content,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomIcon extends StatelessWidget {
  const _CustomIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 11,
      backgroundColor: AppColors.blueRegular,
      child: Icon(
        Icons.check,
        color: AppColors.white,
        size: 14,
      ),
    );
  }
}
