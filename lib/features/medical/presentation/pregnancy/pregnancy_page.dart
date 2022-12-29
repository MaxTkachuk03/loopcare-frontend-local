import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/medical/presentation/medical_intro/widgets/app_bar_sub_title.dart';
import 'package:loopcare_frontend/features/medical/presentation/pregnancy/widgets/pregnancy_chips.dart';

class PregnancyPage extends StatelessWidget {
  const PregnancyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(LocalizedTexts.bodyAndMind.tr()),
            // add values from the BLOC
            const AppBarSubTitle(
              total: 83,
              currentNumber: 8,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 74.0,
                ),
                Text(
                  LocalizedTexts.areYouPregnant.tr(),
                  style: Theme.of(context).textTheme.headline4?.copyWith(),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const PregnancyChips(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
