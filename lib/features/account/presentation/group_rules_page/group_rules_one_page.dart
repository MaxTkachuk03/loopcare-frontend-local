import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class GroupRulesOnePage extends StatelessWidget {
  final GroupPrefsMode groupPrefsMode;

  const GroupRulesOnePage({Key? key, required this.groupPrefsMode}) : super(key: key);

  void _onContinuePressHandler(BuildContext context) {
    context.router.push(GroupRulesTwoRoute(groupPrefsMode: groupPrefsMode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueAppBar,
        leading: const BackButtonHexagon(),
        title: Text(
          LocalizedTexts.groupRules,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
        ).tr(),
      ),
      body: SafeArea(
        child: MainContainer(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 28.0),
                    const Text(
                      LocalizedTexts.groupRulesOneTitle,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: ThemeConstants.bitterFontFamily,
                      ),
                    ).tr(),
                    const SizedBox(height: 8.0),
                    const Text(
                      LocalizedTexts.groupRulesAttencion,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ).tr(),
                    const SizedBox(height: 16.0),
                    const Text(
                      LocalizedTexts.groupRulesOneParagraphOne,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ).tr(),
                    const SizedBox(height: 32.0),
                    const Text(
                      LocalizedTexts.groupRulesOneParagraphTwo,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ).tr(),
                  ],
                ),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: () => _onContinuePressHandler(context),
                      child: const Text(LocalizedTexts.continueToTheRules).tr(),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
