import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_failed/widgets/failed_information.dart';

class CheckFailedPage extends StatelessWidget {
  const CheckFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.bodyAndMind.tr()),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    FailedInformation(
                      // TODO: add value from  bloc in the future

                      bmi: '52',
                      informationsText: LocalizedTexts
                          .fitnessCheckFailedInformationsText
                          .tr(),
                      adviceText:
                          LocalizedTexts.fitnessCheckFailedAdviceText.tr(),
                      moreInfoPressed: _onMoreInfoPressed,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onMoreInfoPressed() {}
}
