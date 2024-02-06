import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

class SavedAssignment extends StatelessWidget {
  const SavedAssignment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: const BoxDecoration(
        color: AppColors.petrolLightest,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: CustomText.w700(LocalizedTexts.saved.tr(), style: context.textTheme.bodyMedium),
    );
  }
}
