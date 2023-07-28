import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/divider_light.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/part_of_group.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/tapped_item.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';

class GroupPreferencesForm extends StatelessWidget {
  const GroupPreferencesForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Allocatted to group block without outlined box
    // return WhiteBox(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       PartOfGroup(),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       const DividerLight(),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       TappedItem(
    //         title: LocalizedTexts.yourNickname,
    //         subTitle: 'Catlover',
    //         onPressHandler: () {},
    //       ),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       const DividerLight(),
    //       const SizedBox(
    //         height: 16.0,
    //       ),
    //       OutlinedButton(
    //         style: OutlinedButton.styleFrom(
    //           shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(5.0),
    //             ),
    //           ),
    //           side: const BorderSide(width: 1.0, color: AppColors.greyLabel),
    //           minimumSize: const Size(0, 38.0),
    //           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
    //           textStyle: Theme.of(context).textTheme.bodyMedium,
    //         ),
    //         onPressed: () {},
    //         child: const Text(LocalizedTexts.leaveGroup).tr(),
    //       )
    //     ],
    //   ),
    // );
    return WhiteBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TappedItem(
            title: LocalizedTexts.genderPreference,
            subTitle: 'Mixed',
            onPressHandler: () => _onGenderPreferencesTap(context),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const DividerLight(),
          const SizedBox(
            height: 16.0,
          ),
          TappedItem(
            title: LocalizedTexts.timezone,
            subTitle: 'Los Angeles, California, USA (GMT -7:00)',
            onPressHandler: () => _onTimezoneTap(context),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const DividerLight(),
          const SizedBox(
            height: 16.0,
          ),
          TappedItem(
            title: LocalizedTexts.yourNickname,
            subTitle: 'Catlover',
            onPressHandler: () => _onNicknamePreferencesTap(context),
          ),
          const SizedBox(
            height: 16.0,
          ),
          const DividerLight(),
          const SizedBox(
            height: 16.0,
          ),
          const PartOfGroup(),
          const SizedBox(
            height: 16.0,
          ),
          const DividerLight(),
          const SizedBox(
            height: 16.0,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              side: const BorderSide(width: 1.0, color: AppColors.greyLabel),
              minimumSize: const Size(0, 38.0),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            onPressed: () {},
            child: const Text(LocalizedTexts.iNoLongerWantToJoin).tr(),
          )
        ],
      ),
    );
  }

  void _onGenderPreferencesTap(BuildContext context) {
    context.router.push(GenderPreferencesRoute(groupPrefsMode: GroupPrefsMode.single));
  }

  void _onTimezoneTap(BuildContext context) {
    context.router.push(TimezonePreferencesRoute(groupPrefsMode: GroupPrefsMode.single));
  }

  void _onNicknamePreferencesTap(BuildContext context) {
    context.router.push(NicknamePreferencesRoute(groupPrefsMode: GroupPrefsMode.single));
  }
}
