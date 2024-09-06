import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_chat_report.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_session_report.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/domain/report_abuse_description_validator.dart';
import 'package:loopcare_frontend/features/report_abuse/domain/report_abuse_subject_validator.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/report_abuse_controller.dart';

class ReportAbuseWidget extends StatefulWidget {
  final GroupSessionReport? groupSession;
  final GroupChatReport? chatReport;
  final VoidCallback close;

  const ReportAbuseWidget({super.key, this.groupSession, this.chatReport, required this.close});

  @override
  State<ReportAbuseWidget> createState() => _ReportAbuseWidgetState();
}

class _ReportAbuseWidgetState extends State<ReportAbuseWidget> {
  final ReportAbuseController controller = ReportAbuseController();

  void _onChangeListener(BuildContext context, ReportAbuseState state) {
    state.maybeMap(
      sentSuccess: _showSuccess,
      error: _showError,
      orElse: () => {},
    );
  }

  void _onSendPressed() {
    controller.isFormValid.value = false;

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.reportIssue,
      parameters: {
        AnalyticsParameters.value: controller.reportController.value.text,
      },
    );

    context.read<ReportAbuseBloc>().add(
          ReportAbuseEvent.sendReport(
            controller.subjectController.value.text,
            controller.reportController.value.text,
            groupSession: widget.groupSession,
            chatReport: widget.chatReport,
          ),
        );
  }

  void _showSuccess(_) {
    widget.close();
    context.showSuccessBar(content: CustomText(LocalizedTexts.reportSuccessTitle.tr()));
  }

  void _showError(_) {
    widget.close();
    context.showError(content: CustomText(LocalizedTexts.errorSomethingWentWrong.tr()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportAbuseBloc, ReportAbuseState>(
        listener: _onChangeListener,
        builder: (context, state) {
          return _ReportFormWidget(
            controller: controller,
            close: widget.close,
            onSend: _onSendPressed,
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ReportFormWidget extends StatelessWidget {
  final ReportAbuseController controller;
  final VoidCallback close;
  final Function() onSend;

  const _ReportFormWidget({required this.controller, required this.onSend, required this.close});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CustomText.bitter500(
                LocalizedTexts.reportTitle.tr(),
                textAlign: TextAlign.start,
                style: context.textTheme.displayMedium,
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: IconButton(
                iconSize: 30,
                padding: EdgeInsets.zero,
                onPressed: close,
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
        Expanded(
          child: CustomScaffold(
            withBg: false,
            color: AppColors.transparent,
            appBar: null,
            resizeToAvoidBottomInset: true,
            body: Form(
              key: controller.formKey,
              onChanged: controller.validateForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  CustomText.w400(
                    '${LocalizedTexts.reportSubTitle.tr()}.',
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    key: controller.subjectFieldKey,
                    controller: controller.subjectController,
                    hintText: LocalizedTexts.subjectReport.tr(),
                    textInputAction: TextInputAction.next,
                    validator: reportAbuseSubjectValidator,
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: CustomTextField(
                      key: controller.reportFieldKey,
                      controller: controller.reportController,
                      hintText: LocalizedTexts.descriptionReport.tr(),
                      validator: reportAbuseDescriptionValidator,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLength: 500,
                      minLines: 30,
                      maxLines: 50,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isFormValid,
                    builder: (context, isFormValid, _) => CustomElevatedButton.blueFullWidth(
                      onPressed: isFormValid ? onSend : null,
                      label: LocalizedTexts.send.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
