import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/email_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/login_password_validator.dart';
import 'package:loopcare_frontend/core/presentation/validators/name_validator.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final Icon? prefixIcon;
  final bool? isToggleEye;
  final bool? isClearField;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
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
  final bool readOnly;
  final bool scribbleEnabled;
  final Iterable<String>? autofillHints;
  final void Function()? onEditingComplete;
  final OutlineInputBorder? borderStyle;

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
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
    this.autofillHints,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.scribbleEnabled = false,
    this.borderStyle,
  });

  factory CustomTextField.search({
    Key? key,
    Color? fillColor,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onCleared,
    OutlineInputBorder? borderStyle,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.searchHint.tr(),
        controller: controller,
        prefixIcon: const Icon(Icons.search, size: 22),
        onChanged: onChanged,
        onCleared: onCleared,
        isClearField: onCleared != null,
        fillColor: fillColor,
        borderStyle: borderStyle,
      );

  factory CustomTextField.nickname({
    Key? key,
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        maxLength: 64,
        hintText: LocalizedTexts.nicknamePlaceholder.tr(),
        controller: controller,
        validator: NameValidator.validate,
        keyboardType: TextInputType.name,
        fillColor: fillColor,
        errorText: errorText,
        onChanged: onChanged,
      );

  factory CustomTextField.email({
    Key? key,
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    TextInputAction textInputAction = TextInputAction.next,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourEmail.tr(),
        controller: controller,
        validator: emailValidator(),
        prefixIcon: const Icon(Icons.mail, size: 24),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        fillColor: fillColor,
        textInputAction: textInputAction,
        errorText: errorText,
        onChanged: onChanged,
      );

  factory CustomTextField.buddyEmail({
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        hintText: LocalizedTexts.buddyEmailHint.tr(),
        controller: controller,
        validator: emailValidator(),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        fillColor: fillColor,
        errorText: errorText,
        onChanged: onChanged,
      );

  factory CustomTextField.loginEmail({
    Key? key,
    Color? fillColor,
    String? errorText,
    ValueChanged<String>? onChanged,
    TextInputAction textInputAction = TextInputAction.next,
    void Function()? onEditingComplete,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourEmail.tr(),
        controller: controller,
        validator: emailValidator(),
        prefixIcon: const Icon(Icons.mail, size: 24),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        fillColor: fillColor,
        errorText: errorText,
        onChanged: onChanged,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
      );

  factory CustomTextField.password({
    Key? key,
    Color? fillColor,
    TextInputAction textInputAction = TextInputAction.done,
    void Function()? onEditingComplete,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourPassword.tr(),
        controller: controller,
        validator: loginPasswordValidator(),
        autofillHints: const [AutofillHints.password],
        prefixIcon: const Icon(Icons.lock, size: 24),
        isToggleEye: true,
        textInputAction: textInputAction,
        obscureText: true,
        onEditingComplete: onEditingComplete,
      );

  factory CustomTextField.hiddenEmail({
    Key? key,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourEmail.tr(),
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        readOnly: true,
      );

  factory CustomTextField.hiddenPassword({
    Key? key,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourPassword.tr(),
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        autofillHints: const [AutofillHints.password],
        isToggleEye: true,
        obscureText: true,
        readOnly: true,
      );

  factory CustomTextField.createPassword({
    Key? key,
    Color? fillColor,
    ValueChanged<String>? onChanged,
    required TextEditingController controller,
  }) =>
      CustomTextField(
        key: key,
        hintText: LocalizedTexts.yourPassword.tr(),
        autofillHints: const [AutofillHints.password],
        controller: controller,
        isToggleEye: true,
        obscureText: true,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
      );

  factory CustomTextField.unit({
    Key? key,
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
        key: key,
        hintText: '',
        controller: controller,
        maxLength: maxLength,
        focusNode: focusNode,
        keyboardType:
            TextInputType.numberWithOptions(decimal: isDecimal ?? false),
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

  Widget? get _suffixIcon {
    if (widget.isToggleEye ?? false) {
      return IconButton(
        icon: const Icon(Icons.remove_red_eye, size: 24),
        color: _isObscureText ? AppColors.greyRegular : AppColors.blueDarker,
        onPressed: _toggleEye,
      );
    } else if (widget.isClearField ?? false) {
      return IconButton(
        icon: const Icon(Icons.cancel, size: 24),
        color: AppColors.greyRegular,
        onPressed: _clearField,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  InputDecoration get _defaultDecoration => InputDecoration(
        isDense: true,
        fillColor: widget.fillColor ?? AppColors.white.withOpacity(0.7),
        errorText: widget.errorText,
        counterText: '',
        errorMaxLines: 2,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon,
        enabled: !widget.readOnly,
        focusedBorder: widget.borderStyle,
        enabledBorder: widget.borderStyle,
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      autofillHints: widget.autofillHints,
      controller: widget.controller,
      enableIMEPersonalizedLearning: false,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: _isObscureText,
      textAlign: widget.textAlign,
      style: widget.style ??
          context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: widget.decoration ?? _defaultDecoration,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      onEditingComplete: widget.onEditingComplete,
      scribbleEnabled: widget.scribbleEnabled,
    );
  }
}
