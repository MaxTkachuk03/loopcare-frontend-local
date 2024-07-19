import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class GroupRulesFourPage extends StatelessWidget {
  final RiverModuleStreamType streamType;
  final bool fromLessonComplete;

  const GroupRulesFourPage({
    super.key,
    required this.fromLessonComplete,
    this.streamType = RiverModuleStreamType.psychology,
  });

  void _onIAgreePressHandler(BuildContext context) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      // context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    context.router
        .push(GroupRulesFiveRoute(fromLessonComplete: fromLessonComplete, streamType: streamType));
  }

  @override
  Widget build(BuildContext context) {
    return GroupLessonWrap(
      fromLessonComplete: fromLessonComplete,
      child: GroupPrefsPageWrap(
        streamType: streamType,
        fromLessonComplete: fromLessonComplete,
        child: CustomSafeArea(
          child: MainContainer(
            child: ScrollableContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // const GroupPrefsProgress(),
                      const SizedBox(height: 28.0),
                      CustomText.w600(
                        LocalizedTexts.groupRulesAttention.tr(),
                        style: context.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            style: context.textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                  text:
                                      '${LocalizedTexts.groupRulesFourParagraphOnePartOne.tr()} '),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOneItalicOne.tr()} ',
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextSpan(
                                  text:
                                      '${LocalizedTexts.groupRulesFourParagraphOnePartTwo.tr()} '),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOneItalicTwo.tr()} ',
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextSpan(
                                  text:
                                      '${LocalizedTexts.groupRulesFourParagraphOnePartThree.tr()} '),
                              TextSpan(
                                text: LocalizedTexts.groupRulesFourParagraphOneItalicThree.tr(),
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        bulletSign: '7.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 32.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesFourParagraphTwo.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '8.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onIAgreePressHandler(context),
                        label: LocalizedTexts.yesIAgree.tr(),
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
