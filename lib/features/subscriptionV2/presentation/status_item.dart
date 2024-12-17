import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({
    super.key,
    required this.width,
    required this.isLimited,
    required this.status,
  });

  final double width;
  final bool isLimited;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          gradient: isLimited ? AppColors.limitedOffer : AppColors.mostPopular),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(status,
              style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: isLimited ? FontWeight.w700 : FontWeight.w600)),
        ],
      ),
    );
  }
}
