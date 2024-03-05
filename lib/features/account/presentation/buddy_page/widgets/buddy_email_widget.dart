import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_email_controller.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

class BuddyEmailWidget extends StatefulWidget {
  final BuddyEmailController controller;

  const BuddyEmailWidget({super.key, required this.controller});

  @override
  State<BuddyEmailWidget> createState() => _BuddyEmailState();
}

class _BuddyEmailState extends State<BuddyEmailWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      onChanged: _onChangedForm,
      child: Column(
        children: [
          CustomTextField.buddyEmail(
            controller: widget.controller.emailController,
            errorText: widget.controller.emailErrorText,
            onChanged: _onEmailChanged,
          ),
        ],
      ),
    );
  }

  _onChangedForm() {
    final isValidForm = Email.create(widget.controller.emailController.text).isRight();
    widget.controller.enableNotifier.value = isValidForm;
  }

  void _onEmailChanged(String value) {
    if (widget.controller.emailErrorText == null) return;

    setState(() {
      widget.controller.emailErrorText = null;
    });
  }
}
