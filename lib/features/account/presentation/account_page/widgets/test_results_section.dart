import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';

class TestResultsSection extends StatelessWidget {
  const TestResultsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: LocalizedTexts.testResults),
        SectionItem(title: LocalizedTexts.mentalHealth, onPressHandler: () {}),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
