import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';

class ReportAbuseSection extends StatelessWidget {
  const ReportAbuseSection({super.key});

  void _onPressHandler(BuildContext context) {
    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    ModalBottomSheet.reportAbuse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          SectionTitle(title: LocalizedTexts.reportIssueAndEmergencyTitle.tr()),
          SectionItem(
            title: LocalizedTexts.reportAbuse.tr(),
            onPressHandler: () => _onPressHandler(context),
          ),
          const Divider(height: 1.0, color: AppColors.blueLighter),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: EmergencyBtn(),
          ),
        ],
      ),
    );
  }
}
