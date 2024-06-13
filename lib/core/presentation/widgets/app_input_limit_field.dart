// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/input_decoration.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class AppLimitTextField extends CustomTextField {
  final TextStyle? helperStyle;
  final String? helperText;
  final String? labelText;
  final int? errorMaxLines;
  final IconButton? suffixIcon;
  final int limitCount;
  final int? linesCount;
  final MaxLengthEnforcement enforcedLimitCount;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onSubmitted;
  final Key? fieldKey;
  final String? errorCallback;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final bool expands;
  final int? minLines;
  final bool enabled;
  final Color? focusedColor;
  final Color? cursorColor;
  final double? radius;

  const AppLimitTextField({
    super.key,
    required super.controller,
    this.helperText,
    required super.hintText,
    this.labelText,
    this.helperStyle,
    this.errorMaxLines,
    this.suffixIcon,
    this.fieldKey,
    super.focusNode,
    super.validator,
    this.autovalidateMode,
    super.keyboardType,
    super.onChanged,
    this.onSubmitted,
    this.contentPadding,
    super.obscureText = false,
    super.readOnly = false,
    this.limitCount = 1,
    this.linesCount = 1,
    this.enforcedLimitCount = MaxLengthEnforcement.enforced,
    this.textInputAction,
    this.errorCallback,
    this.expands = false,
    this.minLines,
    this.enabled = true,
    this.focusedColor,
    this.cursorColor,
    this.radius = 8,
  });

  @override
  State<AppLimitTextField> createState() => _InputLimitTextFieldState();
}

class _InputLimitTextFieldState extends State<AppLimitTextField> {
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
            obscureText: widget.obscureText ?? false,
            keyboardType: widget.keyboardType,
            style: widget.style ?? context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            onSubmitted: widget.onSubmitted,
            expands: widget.expands,
            cursorColor: widget.cursorColor ?? AppColors.redFocus,
            decoration: AppInputDecoration.counter(
              context: context,
              radius: widget.radius,
              state: decorationState,
              errorMaxLines: widget.errorMaxLines,
              errorText: errorText,
              labelText: widget.labelText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              focusedColor: widget.focusedColor,
              contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        );
      },
    );
  }
}
