import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_progress.dart';

class GroupRulesSixPage extends StatelessWidget {
  const GroupRulesSixPage({Key? key}) : super(key: key);

  void _onIAgreePressHandler(BuildContext context) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.acceptRules());

    if (groupPrefsMode == GroupPrefsMode.groupPreferencesFlow) {
      context.router.popUntilRouteWithName(GroupPreferencesRoute.name);
    }

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      context.router.pushNamed(AppRoutes.lessonComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GroupLessonWrap(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: context.router.pop,
          ),
          title: Text(
            LocalizedTexts.supportGroupPreferences,
            style: Theme.of(context).textTheme.titleMedium,
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
                      const GroupPrefsProgress(),
                      const SizedBox(height: 28.0),
                      const Text(
                        LocalizedTexts.groupRulesAttencion,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ).tr(),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphOne,
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '11.',
                        bulletSize: 21.0,
                      ),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphTwo,
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '12.',
                        bulletSize: 21.0,
                      ),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphThree,
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '13.',
                        bulletSize: 21.0,
                      ),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphFour,
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                        ).tr(),
                        bulletSign: '14.',
                        bulletSize: 21.0,
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () => _onIAgreePressHandler(context),
                        child: const Text(LocalizedTexts.yesIAgree).tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
