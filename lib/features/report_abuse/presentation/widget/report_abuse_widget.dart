import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/report_abuse_controller.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/report_abuse_fields.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/widget/report_section_title.dart';

class ReportAbuseWidget extends StatefulWidget {
  final GroupSessionReport? groupSession;

  const ReportAbuseWidget({super.key, this.groupSession});

  @override
  State<ReportAbuseWidget> createState() => _ReportAbuseWidgetState();
}

class _ReportAbuseWidgetState extends State<ReportAbuseWidget> {
  late ReportAbuseController controller;

  @override
  void initState() {
    super.initState();
    controller = ReportAbuseController()..addFocusNodeListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportAbuseBloc, ReportAbuseState>(builder: (context, state) {
      return state.maybeMap(
        sentSuccess: (_) {
          controller.isEnableSend.value = false;
          return _ReportAbuseSuccess();
        },
        error: (errorState) {
          final error = errorState.data.error;
          return Center(
            child: ErrorScreen(
              error: error,
              onButtonPressed: () => context.router.pop(),
            ),
          );
        },
        orElse: () => _ReportFormWidget(
          controller: controller,
          onSend: _onSendPressed,
        ),
      );
    });
  }

  _onSendPressed() {
    controller.isEnableSend.value = false;
    context.read<ReportAbuseBloc>().add(ReportAbuseEvent.sendReport(
          controller.subjectController.value.text,
          controller.reportController.value.text,
          groupSession: widget.groupSession,
        ));
  }
}

class _ReportFormWidget extends StatelessWidget {
  final ReportAbuseController controller;
  final Function() onSend;

  const _ReportFormWidget({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ReportSectionTitle(title: LocalizedTexts.reportTitle),
        Expanded(
          child: Card(
            color: AppColors.yellowTrans,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: Form(
                  key: controller.formKey,
                  onChanged: () => controller.isFormValid,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReportSectionTitle(
                        title: LocalizedTexts.reportSubTitle,
                        style: context.textTheme.bodyMedium,
                        color: AppColors.darkGreen,
                      ),
                      SubjectAbuseFormInputField.subject(controller),
                      const SizedBox(height: 16.0),
                      Expanded(child: ReportAbuseFormLimitTextField.report(controller)),
                      const SizedBox(height: 16.0),
                      ValueListenableBuilder<bool>(
                        valueListenable: controller.isEnableSend,
                        builder: (context, isEnableSend, _) {
                          return ElevatedButton(
                            onPressed: isEnableSend ? onSend : null,
                            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                  backgroundColor: isEnableSend
                                      ? MaterialStateProperty.all(AppColors.orangeDark)
                                      : MaterialStateProperty.all(AppColors.greyLight),
                                ),
                            child: const Text(LocalizedTexts.send).tr(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReportAbuseSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ReportSectionTitle(title: LocalizedTexts.reportSuccessTitle.tr()),
        const SizedBox(height: 16.0),
        Text(
          LocalizedTexts.reportSuccessSubTitle.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.darkGreen,
            fontFamily: ThemeConstants.bitterFontFamily,
          ),
        ),
      ],
    );
  }
}
