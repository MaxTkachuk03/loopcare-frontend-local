import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';

class ReportAbuseSection extends StatelessWidget {
  const ReportAbuseSection({Key? key}) : super(key: key);

  void _onPressHandler(BuildContext context) {
    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    ModalBottomSheet.reportAbuse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: SectionItem(
        title: LocalizedTexts.reportAbuse,
        onPressHandler: () => _onPressHandler(context),
      ),
    );
  }
}
