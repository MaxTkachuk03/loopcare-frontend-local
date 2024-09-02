import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';

class TestResultsSection extends StatelessWidget {
  const TestResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          SectionTitle(title: LocalizedTexts.testResults.tr()),
          SectionItem(title: LocalizedTexts.mentalHealth.tr(), onPressHandler: () {}),
        ],
      ),
    );
  }
}
