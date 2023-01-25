import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _onChangedForm,
      child: Column(
        children: [
          Field(
            hintText: LocalizedTexts.yourEmail.tr(),
            prefixIcon: AppIcons.iconMail,
            controller: _emailController,
            validator: emailValidator(),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _isDisabled ? null : _onContinuePressed,
            child: Text(LocalizedTexts.continueBtn.tr()),
          ),
        ],
      ),
    );
  }

  void _onContinuePressed() {}


  void _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight();

    setState(() {
      _isDisabled = !isValidForm;
    });
  }
}
