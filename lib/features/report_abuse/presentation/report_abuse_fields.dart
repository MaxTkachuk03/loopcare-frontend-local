import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/validators/report_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/report_abuse_controller.dart';

class SubjectAbuseFormInputField extends AppInputTextField {
  SubjectAbuseFormInputField.subject(ReportAbuseController controller, {super.key})
      : super(
          fieldKey: controller.subjectFieldKey,
          keyboardType: TextInputType.text,
          focusNode: controller.subjectFocusNode,
          textInputAction: TextInputAction.next,
          controller: controller.subjectController,
          hintText: LocalizedTexts.subjectReport.tr(),
          validator: validateSubjectAbuseField,
          autovalidateMode: controller.subjectAutoValidateMode,
          onChanged: (_) {},
          enforcedLimitCount: MaxLengthEnforcement.none,
          linesCount: null,
        );
}

class ReportAbuseFormLimitTextField extends AppLimitTextField {
  ReportAbuseFormLimitTextField.report(ReportAbuseController controller, {super.key})
      : super(
          fieldKey: controller.reportFieldKey,
          focusNode: controller.reportFocusNode,
          controller: controller.reportController,
          hintText: LocalizedTexts.descriptionReport.tr(),
          validator: validateReportAbuseField,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.multiline,
          autovalidateMode: controller.reportAutoValidateMode,
          onChanged: (_) {},
          enforcedLimitCount: MaxLengthEnforcement.none,
          limitCount: 500,
          minLines: 30,
          linesCount: 50,
        );
}
