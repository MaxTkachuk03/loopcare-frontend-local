import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_content_v2.dart';

class CheckedItem extends StatelessWidget {
  const CheckedItem({
    super.key,
    required this.index,
    required this.contentLength,
    required this.content,
  });

  final int index;
  final int contentLength;
  final List<SubscriptionPlanContentV2> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcons.dashedBorder,
        const SizedBox(height: 4.0),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: contentLength,
            itemBuilder: (context, id) {
              return CustomText.w400(
                content[id].text,
                style: context.textTheme.bodySmall,
              );
            }),
      ],
    );
  }
}
