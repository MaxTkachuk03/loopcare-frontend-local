import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SearchEmptyResult extends StatelessWidget {
  const SearchEmptyResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greenLightest,
      width: double.infinity,
      padding: const EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.w600(
            LocalizedTexts.searchEmptyResultTitle.tr(),
            style: context.textTheme.titleLarge?.copyWith(color: AppColors.blueRegular),
          ),
          const SizedBox(height: 8.0),
          CustomText.w500(
            LocalizedTexts.searchEmptyResultText.tr(),
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
