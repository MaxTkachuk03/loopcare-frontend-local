import 'package:flutter/material.dart';

class ReportAbuseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isEnableSend = ValueNotifier(false);
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController reportController = TextEditingController();

  final GlobalKey<FormFieldState<String>> subjectFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> reportFieldKey = GlobalKey<FormFieldState<String>>();

  final FocusNode subjectFocusNode = FocusNode();
  final FocusNode reportFocusNode = FocusNode();

  AutovalidateMode subjectAutoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode reportAutoValidateMode = AutovalidateMode.disabled;

  bool get isFormValid => isEnableSend.value =
      (subjectFieldKey.currentState?.isValid ?? false) && (reportFieldKey.currentState?.isValid ?? false);

  void addFocusNodeListeners() {
    subjectFocusNode.addListener(() {
      if (!subjectFocusNode.hasFocus) {
        subjectController.text = subjectController.value.text.trim();
        subjectFieldKey.currentState?.validate();
        subjectAutoValidateMode = AutovalidateMode.always;
      }
    });
    reportFocusNode.addListener(() {
      if (!reportFocusNode.hasFocus) {
        reportController.text = reportController.value.text.trim();
        reportFieldKey.currentState?.validate();
        reportAutoValidateMode = AutovalidateMode.always;
      }
    });
  }

  void dispose() {
    subjectController.dispose();
    reportController.dispose();
    subjectFocusNode.dispose();
    reportFocusNode.dispose();
  }
}
