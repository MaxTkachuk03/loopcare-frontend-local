import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/diabetes/presentation/diabetes/widgets/diabetes_type_chips.dart';

class DiabetesPage extends StatelessWidget {
  const DiabetesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(LocalizedTexts.diabetes.tr()),
            Text(
              '1 ${LocalizedTexts.of.tr()} 1',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
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
                  LocalizedTexts.doYouHaveDiabetesQuestion.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const DiabetesTypeChips(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
