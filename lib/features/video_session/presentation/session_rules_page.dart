import 'package:auto_route/annotations.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_countdown.dart';

const double _bottomSheetHeight = 167.0;

@RoutePage()
class SessionRulesPage extends StatelessWidget {
  const SessionRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.orange(
      appBar: CustomAppBar.orange(
        title: LocalizedTexts.groupRules.tr(),
        leading: CustomFilledIconButton.leadingOrangeLighter(),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: _bottomSheetHeight,
        color: AppColors.blueDarker,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        child: const SessionCountdown(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                const SizedBox(height: 28.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 32.0),
                  decoration: BoxDecoration(
                    color: AppColors.orangeLightest,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    border: Border.all(
                      width: 2,
                      color: AppColors.petrolRegular,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.bitter600(
                        LocalizedTexts.groupRulesAttention.tr(),
                        style: context.textTheme.bodyLarge?.copyWith(fontSize: ThemeConstants.fontSize20),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.0),
                        child: Column(
                          children: [
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesTwoParagraphOne.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '1.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesTwoParagraphTwo.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '2.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesTwoParagraphThree.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '3.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesThreeParagraphOne.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '4.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesThreeParagraphTwo.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '5.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesThreeParagraphThree.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                              bulletSign: '6.',
                            ),
                            const SizedBox(height: 16.0),
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
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesFourParagraphTwo.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSign: '8.',
                              bulletSize: 18.0,
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: CustomText.w400(
                                LocalizedTexts.groupRulesFiveParagraphOne.tr(),
                                style: context.textTheme.bodyLarge,
                              ),
                              bulletSign: '9.',
                              bulletSize: 18.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesFiveParagraphTwo.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '10.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesSixParagraphOne.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '11.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesSixParagraphTwo.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '12.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesSixParagraphThree.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '13.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.groupRulesSixParagraphFour.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                        bulletSign: '14.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                const SizedBox(height: _bottomSheetHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
