import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/login_password_validator.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final AssetImage? prefixIcon;
  final bool? isToggleEye;
  final bool? isClearField;
  final int? maxLength;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCleared;
  final EdgeInsetsGeometry? contentPadding;
  final bool? autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.maxLength,
    this.errorText,
    this.isToggleEye,
    this.onCleared,
    this.isClearField,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.autofocus,
  });

  factory CustomTextField.email({
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.yourEmail,
        controller: controller,
        validator: emailValidator(),
        prefixIcon: AppIcons.iconMail,
        keyboardType: TextInputType.emailAddress,
      );

  factory CustomTextField.password({
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.yourPassword,
        controller: controller,
        validator: loginPasswordValidator(),
        prefixIcon: AppIcons.iconLock,
        isToggleEye: true,
        obscureText: true,
      );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscureText = false;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.obscureText ?? false;
  }

  void _toggleEye() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  void _clearField() {
    setState(() {
      widget.controller.clear();
    });

    widget.onCleared?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      controller: widget.controller,
      enableIMEPersonalizedLearning: false,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      obscureText: _isObscureText,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.7),
        errorText: widget.errorText,
        counterText: '',
        contentPadding: widget.contentPadding,
        errorMaxLines: 2,
        hintText: widget.hintText.tr(),
        prefixIcon: ImageIcon(widget.prefixIcon),
        suffixIcon: widget.isToggleEye ?? false
            ? IconButton(
                icon: const ImageIcon(AppIcons.iconOpenEye),
                color: _isObscureText ? AppColors.greyRegular : AppColors.blueDarker,
                onPressed: _toggleEye,
              )
            : widget.isClearField ?? false
                ? IconButton(
                    icon: const Icon(CupertinoIcons.clear_thick_circled),
                    color: AppColors.greyRegular,
                    onPressed: _clearField,
                  )
                : null,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
    );
  }
}
