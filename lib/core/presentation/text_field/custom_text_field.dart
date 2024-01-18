import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/login_password_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/name_validator.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final Icon? prefixIcon;
  final bool? isToggleEye;
  final bool? isClearField;
  final int? maxLength;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCleared;
  final Color? fillColor;
  final bool? autofocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextAlign textAlign;

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
    this.autofocus,
    this.fillColor,
    this.focusNode,
    this.inputFormatters,
    this.decoration,
    this.style,
    this.textAlign = TextAlign.start,
  });

  factory CustomTextField.search({
    Color? fillColor,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onCleared,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.searchHint.tr(),
        controller: controller,
        prefixIcon: const Icon(Icons.search, size: 22),
        onChanged: onChanged,
        onCleared: onCleared,
        isClearField: onCleared != null,
        fillColor: fillColor,
      );

  factory CustomTextField.nickname({
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        maxLength: 64,
        hintText: LocalizedTexts.nicknamePlaceholder,
        controller: controller,
        validator: nameValidator(),
        keyboardType: TextInputType.name,
        fillColor: fillColor,
        errorText: errorText,
        onChanged: onChanged,
      );

  factory CustomTextField.email({
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.yourEmail,
        controller: controller,
        validator: emailValidator(),
        prefixIcon: const Icon(Icons.mail, size: 24),
        keyboardType: TextInputType.emailAddress,
        fillColor: fillColor,
        errorText: errorText,
        onChanged: onChanged,
      );

  factory CustomTextField.password({
    Color? fillColor,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.yourPassword,
        controller: controller,
        validator: loginPasswordValidator(),
        prefixIcon: const Icon(Icons.lock, size: 24),
        isToggleEye: true,
        obscureText: true,
      );

  factory CustomTextField.createPassword({
    Color? fillColor,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.yourPassword,
        controller: controller,
        isToggleEye: true,
        obscureText: true,
        onChanged: onChanged,
      );

  factory CustomTextField.unit({
    Color? fillColor,
    required TextEditingController controller,
    FocusNode? focusNode,
    required int maxLength,
    bool? isDecimal,
    final List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    TextStyle? style,
    InputDecoration? decoration,
  }) =>
      CustomTextField(
        hintText: '',
        controller: controller,
        maxLength: maxLength,
        focusNode: focusNode,
        keyboardType: TextInputType.numberWithOptions(decimal: isDecimal ?? false),
        fillColor: fillColor,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        style: style,
        decoration: decoration,
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

  get _suffixIcon {
    return widget.isToggleEye ?? false
        ? IconButton(
            icon: const Icon(Icons.remove_red_eye, size: 24),
            color: _isObscureText ? AppColors.greyRegular : AppColors.blueDarker,
            onPressed: _toggleEye,
          )
        : widget.isClearField ?? false
            ? IconButton(
                icon: const Icon(CupertinoIcons.clear_thick_circled, size: 24),
                color: AppColors.greyRegular,
                onPressed: _clearField,
              )
            : null;
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
      textAlign: widget.textAlign,
      style: widget.style ?? context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      maxLength: widget.maxLength,
      decoration: widget.decoration ??
          InputDecoration(
            isDense: true,
            fillColor: widget.fillColor ?? AppColors.white.withOpacity(0.7),
            errorText: widget.errorText,
            counterText: '',
            errorMaxLines: 2,
            hintText: widget.hintText.tr(),
            prefixIcon: widget.prefixIcon,
            suffixIcon: _suffixIcon,
          ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
    );
  }
}
