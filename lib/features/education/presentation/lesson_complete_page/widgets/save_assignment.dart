import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

// todo: check if this is still needed
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
