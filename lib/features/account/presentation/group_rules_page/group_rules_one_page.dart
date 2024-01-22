import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_progress.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class GroupRulesOnePage extends StatelessWidget {
  const GroupRulesOnePage({super.key});

  void _onContinuePressHandler(BuildContext context) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    context.router.pushNamed(AppRoutes.groupRulesTwo);
  }

  @override
  Widget build(BuildContext context) {
    return GroupLessonWrap(
      // TODO: need check
      child: GroupPrefsPageWrap(
        title: LocalizedTexts.groupRules.translation,
        child: SafeArea(
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
                      CustomText.bitter700(LocalizedTexts.groupRulesOneTitle.tr()),
                      const SizedBox(height: 8.0),
                      CustomText.w600(LocalizedTexts.groupRulesAttencion.tr()),
                      const SizedBox(height: 16.0),
                      CustomText.w400(LocalizedTexts.groupRulesOneParagraphOne.tr()),
                      const SizedBox(height: 32.0),
                      CustomText.w400(LocalizedTexts.groupRulesOneParagraphTwo.tr()),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: [
                      CustomOutlinedButton.blueFullWidth(
                        onPressed: () => _onContinuePressHandler(context),
                        label: LocalizedTexts.continueToTheRules.tr(),
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
