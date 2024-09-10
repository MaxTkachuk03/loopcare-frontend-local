import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
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
                    Expanded(child: CustomText(LocalizedTexts.wouldYouLikeToJoinSupportGroup.tr())),
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
                    return CustomText(
                      s.wouldLikeJoinGroup?.name.tr().capitalize() ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    );
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
      ..read<GroupPreferencesBloc>().add(
          const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupPreferencesFlow))
      ..router.push(JoinGroupPreferencesRoute(fromLessonComplete: false));
  }
}
