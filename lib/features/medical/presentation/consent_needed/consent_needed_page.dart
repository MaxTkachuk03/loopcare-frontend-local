import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/medical/presentation/medical_intro/widgets/app_bar_sub_title.dart';

class ConsentNeededPage extends StatelessWidget {
  const ConsentNeededPage({Key? key}) : super(key: key);

  final double hexagonSize = 65.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(LocalizedTexts.bodyAndMind.tr()),
            const AppBarSubTitle(),
          ],
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 58.0,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: hexagonSize / 2),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 44,
                              bottom: 58,
                              left: 40,
                              right: 36,
                            ),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  LocalizedTexts.needConsentBodyText1.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  LocalizedTexts.needConsentBodyText2.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(),
                                ),
                                const SizedBox(
                                  height: 36.0,
                                ),
                                ElevatedButton(
                                  onPressed: _onDownloadInstructionsPressed,
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.blueDark),
                                      ),
                                  child: Text(
                                    LocalizedTexts.downloadInstructions.tr(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Hexagon(
                            width: hexagonSize,
                            height: hexagonSize,
                            borderRadius: 15.0,
                            innerWidget: Container(
                              color: AppColors.blueDark,
                              child: AppImages.exclamationMark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _onNextPressed,
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(
                        LocalizedTexts.continueBtn.tr(),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPressed() {}

  void _onDownloadInstructionsPressed() {}
}
