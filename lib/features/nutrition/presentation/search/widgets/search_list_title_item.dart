import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 25,
              right: 16,
            ),
            child: CustomText.w600(
              text,
              style: Theme.of(context).textTheme.titleMedium,
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
