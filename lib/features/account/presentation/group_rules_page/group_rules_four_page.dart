import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class GroupRulesFourPage extends StatelessWidget {
  const GroupRulesFourPage({super.key});

  void _onIAgreePressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupRulesFive);
  }

  @override
  Widget build(BuildContext context) {
    return GroupLessonWrap(
      child: GroupPrefsPageWrap(
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
                                text: '${LocalizedTexts.groupRulesFourParagraphOnePartOne.tr()} ',
                              ),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOneItalicOne.tr()} ',
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOnePartTwo.tr()} ',
                              ),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOneItalicTwo.tr()} ',
                                style: const TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextSpan(
                                text: '${LocalizedTexts.groupRulesFourParagraphOnePartThree.tr()} ',
                              ),
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
