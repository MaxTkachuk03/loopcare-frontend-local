import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SearchListTitleItem extends StatelessWidget {
  final String text;

  const SearchListTitleItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greenLighter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 24.0,
            ),
            child: CustomText.w600(
              text,
              style: context.textTheme.titleMedium,
            ),
          ),
          const Divider(
            color: AppColors.yellowLight,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
