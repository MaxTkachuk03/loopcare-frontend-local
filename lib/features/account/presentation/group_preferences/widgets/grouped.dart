import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';

class Grouped extends StatelessWidget {
  const Grouped({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WhiteBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.bitter600(
                LocalizedTexts.goodNews.tr(),
                style: context.textTheme.bodyLarge?.copyWith(fontSize: ThemeConstants.fontSize20),
              ),
              const Text(LocalizedTexts.youHaveBeenAddedToGroup).tr(),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const GroupPreferencesForm()
      ],
    );
  }
}
