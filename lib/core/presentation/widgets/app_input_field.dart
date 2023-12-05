// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/themes/input_decoration.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppTextField extends StatefulWidget {
  final TextStyle? helperStyle;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final int? errorMaxLines;
  final IconButton? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextEditingController controller;
  final bool readOnly;
  final Key? fieldKey;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final String? errorCallback;
  final Color focusColor;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final MaxLengthEnforcement enforcedLimitCount;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? linesCount;
  final bool enabled;
  final bool? enableInteractiveSelection;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    required this.controller,
    this.helperText,
    this.hintText,
    this.labelText,
    this.helperStyle,
    this.errorMaxLines = 4,
    this.suffixIcon,
    this.fieldKey,
    this.focusNode,
    this.validator,
    this.autovalidateMode,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.readOnly = false,
    this.errorCallback,
    this.focusColor = AppColors.grey,
    this.inputFormatters = const [],
    this.autofillHints,
    this.maxLength,
    this.linesCount = 1,
    this.enforcedLimitCount = MaxLengthEnforcement.enforced,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
    this.enableInteractiveSelection,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode
      ..onKeyEvent = _keyListener
      ..addListener(_focusListener);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_focusListener);
    }

    super.dispose();
  }

  void _focusListener() => setState(() {});

  KeyEventResult _keyListener(FocusNode node, KeyEvent event) {
    if (event.logicalKey.keyLabel == "Tab") {
      _focusNode.nextFocus();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: widget.fieldKey,
      enabled: widget.enabled,
      initialValue: widget.controller.text,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (field) {
        void onChangedHandler(String value) {
          field.didChange(value);
          widget.onChanged?.call(value);
        }

        final errorText = widget.errorCallback ?? field.errorText;

        InputDecorationState decorationState;
        if (!widget.enabled) {
          decorationState = InputDecorationState.disable;
        } else if (_focusNode.hasFocus && (errorText?.isEmpty ?? true)) {
          decorationState = InputDecorationState.focused;
        } else if (errorText?.isNotEmpty ?? false) {
          decorationState = InputDecorationState.error;
        } else {
          decorationState = InputDecorationState.enable;
        }

        return UnmanagedRestorationScope(
          bucket: field.bucket,
          child: TextField(
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            controller: widget.controller,
            readOnly: widget.readOnly,
            maxLength: widget.maxLength,
            maxLines: widget.linesCount,
            maxLengthEnforcement: widget.enforcedLimitCount,
            cursorColor: AppColors.redFocus,
            onChanged: onChangedHandler,
            obscureText: widget.obscureText,
            autofillHints: widget.autofillHints,
            keyboardType: widget.keyboardType,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: ThemeConstants.fontSize16,
                ),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            textAlignVertical: TextAlignVertical.center,
            decoration: AppInputDecoration(
              context: context,
              state: decorationState,
              errorMaxLines: widget.errorMaxLines,
              errorText: errorText,
              labelText: widget.labelText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        );
      },
    );
  }
}
