import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class PartOfGroup extends StatelessWidget {
  const PartOfGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, state) {
        if (state.data.groupingState == null) return const SizedBox.shrink();

        if (state.data.isUserGrouped) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(LocalizedTexts.partOfGroup.tr(), style: context.textTheme.bodyMedium),
              CustomText.w600(LocalizedTexts.yes.tr().capitalize(), style: context.textTheme.bodySmall),
              const SizedBox(height: 16.0),
              CustomOutlinedButton.blueFullWidth(
                label: LocalizedTexts.readTheGroupRules.tr(),
                onPressed: () => _onPressed(context),
              )
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.w400(LocalizedTexts.partOfGroup.tr(), style: context.textTheme.bodyMedium),
            CustomText.w600(LocalizedTexts.notYet.tr(), style: context.textTheme.bodySmall),
          ],
        );
      },
    );
  }

  _onPressed(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupPreferencesFlow))
      ..router.push(GroupRulesOneRoute(fromLessonComplete: false));
  }
}
