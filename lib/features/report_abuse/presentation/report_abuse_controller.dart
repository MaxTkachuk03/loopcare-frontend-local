import 'package:flutter/material.dart';

class ReportAbuseController {
  final formKey = GlobalKey<FormState>();
  final subjectFieldKey = GlobalKey<FormFieldState>();
  final reportFieldKey = GlobalKey<FormFieldState>();
  ValueNotifier<bool> isFormValid = ValueNotifier(false);
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController reportController = TextEditingController();

  void dispose() {
    subjectController.dispose();
    reportController.dispose();
    isFormValid.dispose();
  }
}
