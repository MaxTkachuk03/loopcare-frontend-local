import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/features/video_session/presentation/widgets/session_countdown/session_countdown.dart';

class SessionRulesPage extends StatelessWidget {
  const SessionRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: LocalizedTexts.groupRules.tr(),
        leading: const BackButtonHexagon(),
      ),
      body: SafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ScrollableContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 24.0),
                      const Text(
                        '${LocalizedTexts.groupRulesAttencion}.',
                        style: TextStyle(
                          color: AppColors.darkGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ).tr(),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.0),
                        child: Column(
                          children: [
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesTwoParagraphOne,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '1.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesTwoParagraphTwo,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '2.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesTwoParagraphThree,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '3.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesThreeParagraphOne,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '4.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesThreeParagraphTwo,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '5.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesThreeParagraphThree,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSize: 18.0,
                              bulletSign: '6.',
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: RichText(
                                // TODO used to scale properly when user change font size in settings
                                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontFamily: ThemeConstants.openSansFontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.darkGreen),
                                  children: [
                                    TextSpan(
                                        text: '${LocalizedTexts.groupRulesFourParagraphOnePartOne.tr()} '),
                                    TextSpan(
                                      text: '${LocalizedTexts.groupRulesFourParagraphOneItalicOne.tr()} ',
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                        text: '${LocalizedTexts.groupRulesFourParagraphOnePartTwo.tr()} '),
                                    TextSpan(
                                      text: '${LocalizedTexts.groupRulesFourParagraphOneItalicTwo.tr()} ',
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                        text: '${LocalizedTexts.groupRulesFourParagraphOnePartThree.tr()} '),
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
                              text: const Text(
                                LocalizedTexts.groupRulesFourParagraphTwo,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSign: '8.',
                              bulletSize: 18.0,
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: const Text(
                                LocalizedTexts.groupRulesFiveParagraphOne,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              ).tr(),
                              bulletSign: '9.',
                              bulletSize: 18.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesFiveParagraphTwo,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '10.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphOne,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '11.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphTwo,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '12.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphThree,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ).tr(),
                        bulletSign: '13.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                      BulletListItem(
                        text: const Text(
                          LocalizedTexts.groupRulesSixParagraphFour,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ).tr(),
                        bulletSign: '14.',
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              const SessionCountdown(),
            ],
          ),
        ),
      ),
    );
  }
}
