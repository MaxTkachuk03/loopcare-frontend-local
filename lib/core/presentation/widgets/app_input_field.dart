// Flutter imports:
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/input_decoration.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class AppInputTextField extends CustomTextField {
  final TextStyle? helperStyle;
  final String? helperText;
  final String? labelText;
  final int? errorMaxLines;
  final IconButton? suffixIcon;

  final void Function(String)? onSubmitted;
  final Key? fieldKey;
  final AutovalidateMode? autovalidateMode;
  final String? errorCallback;
  final Color focusColor;
  final MaxLengthEnforcement enforcedLimitCount;
  final TextInputAction? textInputAction;
  final int? linesCount;
  final bool enabled;
  final bool? enableInteractiveSelection;
  final TextCapitalization textCapitalization;
  final double? radius;

  const AppInputTextField({
    super.key,
    required super.controller,
    this.helperText,
    required super.hintText,
    this.labelText,
    this.helperStyle,
    this.errorMaxLines = 2,
    this.suffixIcon,
    this.fieldKey,
    super.focusNode,
    super.validator,
    this.autovalidateMode,
    this.textInputAction,
    super.keyboardType,
    super.onChanged,
    this.onSubmitted,
    super.obscureText = false,
    super.readOnly = false,
    this.errorCallback,
    this.focusColor = AppColors.grey,
    super.inputFormatters = const [],
    super.autofillHints,
    super.maxLength,
    this.linesCount = 1,
    this.enforcedLimitCount = MaxLengthEnforcement.enforced,
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true,
    this.enableInteractiveSelection,
    this.radius = 8,
  });

  @override
  State<AppInputTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppInputTextField> {
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
          child: TextFormField(
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            controller: widget.controller,
            readOnly: widget.readOnly,
            maxLength: widget.maxLength,
            maxLines: widget.linesCount,
            maxLengthEnforcement: widget.enforcedLimitCount,
            cursorColor: AppColors.redFocus,
            onChanged: onChangedHandler,
            obscureText: widget.obscureText ?? false,
            autofillHints: widget.autofillHints,
            keyboardType: widget.keyboardType,
            style:
                widget.style ?? context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            // onSubmitted: widget.onSubmitted,
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
              hintText: widget.hintText.tr(),
              suffixIcon: widget.suffixIcon,
              radius: widget.radius,
            ),
          ),
        );
      },
    );
  }
}
