// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/themes/input_decoration.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppLimitTextField extends StatefulWidget {
  final TextStyle? helperStyle;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final int? errorMaxLines;
  final IconButton? suffixIcon;
  final int limitCount;
  final int? linesCount;
  final MaxLengthEnforcement enforcedLimitCount;
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
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final bool expands;
  final int? minLines;
  final bool enabled;

  const AppLimitTextField({
    super.key,
    required this.controller,
    this.helperText,
    this.hintText,
    this.labelText,
    this.helperStyle,
    this.errorMaxLines,
    this.suffixIcon,
    this.fieldKey,
    this.focusNode,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.contentPadding,
    this.obscureText = false,
    this.readOnly = false,
    this.limitCount = 1,
    this.linesCount = 1,
    this.enforcedLimitCount = MaxLengthEnforcement.enforced,
    this.textInputAction,
    this.errorCallback,
    this.expands = false,
    this.minLines,
    this.enabled = true,
  });

  @override
  State<AppLimitTextField> createState() => _AppLimitTextFieldState();
}

class _AppLimitTextFieldState extends State<AppLimitTextField> {
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
      enabled: widget.enabled,
      initialValue: widget.controller.text,
      key: widget.fieldKey,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (field) {
        void onChangedHandler(String value) {
          field.didChange(value);

          if (value.length > widget.limitCount) {
            field.validate();
          } else if (value.length < widget.limitCount && field.hasError) {
            field.validate();
          }

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
            maxLength: widget.limitCount,
            maxLines: widget.linesCount,
            minLines: widget.minLines,
            maxLengthEnforcement: widget.enforcedLimitCount,
            onChanged: onChangedHandler,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: ThemeConstants.fontSize16,
                ),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            onSubmitted: widget.onSubmitted,
            expands: widget.expands,
            cursorColor: AppColors.redFocus,
            decoration: AppInputDecoration.counter(
              context: context,
              state: decorationState,
              errorMaxLines: widget.errorMaxLines,
              errorText: errorText,
              labelText: widget.labelText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        );
      },
    );
  }
}
