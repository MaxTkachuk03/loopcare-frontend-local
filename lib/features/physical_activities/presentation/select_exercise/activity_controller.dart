import 'package:flutter/material.dart';

class ActivityController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isEnableSend = ValueNotifier(false);
  final TextEditingController activityController = TextEditingController();

  final GlobalKey<FormFieldState<String>> activityFieldKey = GlobalKey<FormFieldState<String>>();

  final FocusNode activityFocusNode = FocusNode();

  AutovalidateMode activityAutoValidateMode = AutovalidateMode.disabled;

  bool get isFormValid => isEnableSend.value = (activityFieldKey.currentState?.isValid ?? false);

  void addFocusNodeListeners() {
    activityFocusNode.addListener(() {
      if (!activityFocusNode.hasFocus) {
        activityController.text = activityController.value.text.trim();
        activityFieldKey.currentState?.validate();
        activityAutoValidateMode = AutovalidateMode.always;
      }
    });
  }

  void dispose() {
    activityController.dispose();
    isEnableSend.dispose();
  }
}
