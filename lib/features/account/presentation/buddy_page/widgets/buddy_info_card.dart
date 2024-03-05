import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class BuddyInfoCard extends StatelessWidget {
  final String title;

  const BuddyInfoCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                title,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
