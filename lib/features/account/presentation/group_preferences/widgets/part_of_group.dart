import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PartOfGroup extends StatelessWidget {
  const PartOfGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(builder: (BuildContext context, state) {
      if (state.groupingState == null) return const SizedBox.shrink();

      if (state.isUserGrouped) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(LocalizedTexts.partOfGroup).tr(),
            Text(
              LocalizedTexts.yes.capitalize(),
              style: Theme.of(context).textTheme.headlineSmall,
            ).tr(),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 26,
              child: TextButton(
                onPressed: () => _onPressed(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  foregroundColor: AppColors.blueDark,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                child: const Text(LocalizedTexts.readTheGroupRules).tr(),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(LocalizedTexts.partOfGroup).tr(),
          Text(
            LocalizedTexts.notYet,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.greyLabel,
                  fontWeight: FontWeight.w600,
                ),
          ).tr()
        ],
      );
    });
  }

  _onPressed(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupPreferencesFlow))
      ..router.pushNamed(AppRoutes.groupRulesOne);
  }
}
