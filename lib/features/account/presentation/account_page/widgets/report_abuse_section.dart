import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';

class ReportAbuseSection extends StatelessWidget {
  const ReportAbuseSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(children: [
        SectionItem(title: LocalizedTexts.reportAbuse, onPressHandler: () {}),
      ]),
    );
  }
}
