import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/outlined_box.dart';

const date = 'Friday 8th July 2023 at 4:33PM.';

class CanNotFindGroup extends StatelessWidget {
  const CanNotFindGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.update,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.blueDark),
              ).tr(),
              RichText(
                text: TextSpan(
                  text: '${LocalizedTexts.weHaveNotYetFound.translation}\n',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                        text: date,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: '\n\n${LocalizedTexts.toSpeedUpTheProcess.translation}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              )
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
