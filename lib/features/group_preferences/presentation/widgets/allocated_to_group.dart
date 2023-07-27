import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/group_preferences/presentation/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/group_preferences/presentation/widgets/outlined_box.dart';

class AllocatedToGroup extends StatelessWidget {
  const AllocatedToGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.goodNews,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.blueDark),
              ).tr(),
              const Text(LocalizedTexts.youHaveBeenAddedToGroup).tr(),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const GroupPreferencesForm()
      ],
    );
  }
}
