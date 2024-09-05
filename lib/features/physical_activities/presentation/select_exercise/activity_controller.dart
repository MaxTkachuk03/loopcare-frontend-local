import 'package:flutter/material.dart';

class ActivityController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> activityFieldKey = GlobalKey<FormFieldState<String>>();
  ValueNotifier<bool> isFormValid = ValueNotifier(false);
  final TextEditingController activityController = TextEditingController();

  void dispose() {
    activityController.dispose();
    isFormValid.dispose();
  }
}
