import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';

class NotGrouped extends StatelessWidget {
  const NotGrouped({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WhiteBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _onPressed(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: const Text(LocalizedTexts.wouldYouLikeToJoinSupportGroup).tr()),
                    const ImageIcon(
                      AppIcons.arrow,
                      color: AppColors.greyLabel,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
                  builder: (BuildContext context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  updated: (s) {
                    return Text(
                      s.wouldLikeJoinGroup?.name.capitalize() ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ).tr();
                  },
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  _onPressed(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupPreferencesFlow))
      ..router.pushNamed(AppRoutes.joinGroupPreferences);
  }
}
