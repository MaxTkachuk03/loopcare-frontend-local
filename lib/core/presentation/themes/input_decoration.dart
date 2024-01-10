import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const Color _kEnabledText = AppColors.darkGreen;
const Color _kFocused = AppColors.grey;
const Color _kDisabledText = AppColors.grey;
const Color _kDisabled = AppColors.greyDisable;
const Color _kError = AppColors.redFocus;
const Color _kHint = AppColors.grey;

class AppInputDecoration extends InputDecoration {
  final BuildContext context;

  AppInputDecoration({
    required this.context,
    InputDecorationState state = InputDecorationState.enable,
    super.labelText,
    super.suffixIcon,
    super.errorMaxLines,
    super.hintText,
    super.errorText,
    EdgeInsetsGeometry? contentPadding,
    Color? focusedColor,
    InputBorder? enableBorder,
    double? radius,
  }) : super(
          fillColor: AppColors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0))),
          focusColor: focusedColor ?? _kFocused,
          enabledBorder: enableBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
                borderSide: BorderSide(color: state.color.withOpacity(0.5)),
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: BorderSide(
              color: focusedColor ?? _kFocused,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(color: _kError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(
              color: _kError,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(color: _kDisabled),
          ),
          filled: true,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: _kHint,
            fontSize: ThemeConstants.fontSize16,
          ),
          labelStyle: context.textTheme.bodyMedium?.copyWith(
            color: state.color,
            fontSize: ThemeConstants.fontSize16,
          ),
          errorStyle: context.textTheme.bodyMedium?.copyWith(
            color: _kError,
            fontSize: ThemeConstants.fontSize12,
          ),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
          counterText: '',
          alignLabelWithHint: true,
        );

  AppInputDecoration.counter({
    required this.context,
    InputDecorationState state = InputDecorationState.enable,
    super.labelText,
    super.suffixIcon,
    super.errorMaxLines,
    super.hintText,
    super.errorText,
    EdgeInsetsGeometry? contentPadding,
    String super.counterText = "",
    Color? focusedColor,
    double? radius,
  }) : super(
          fillColor: AppColors.white,
          border: const OutlineInputBorder(),
          focusColor: focusedColor ?? _kFocused,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: BorderSide(color: state.color.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: BorderSide(
              color: focusedColor ?? _kFocused,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(color: _kError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(
              color: _kError,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.0)),
            borderSide: const BorderSide(color: _kDisabled),
          ),
          filled: true,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: _kHint,
            fontSize: ThemeConstants.fontSize16,
          ),
          labelStyle: context.textTheme.bodyMedium?.copyWith(
            color: state.color,
            fontSize: ThemeConstants.fontSize16,
          ),
          errorStyle: context.textTheme.bodyMedium?.copyWith(
            color: _kError,
            fontSize: ThemeConstants.fontSize12,
          ),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 19.0, horizontal: 16.0),
        );
}

class InputDecorationState {
  final Color color;

  const InputDecorationState(this.color);

  static const InputDecorationState enable = InputDecorationState(_kEnabledText);

  static const InputDecorationState disable = InputDecorationState(_kDisabledText);

  static const InputDecorationState focused = InputDecorationState(_kFocused);

  static const InputDecorationState error = InputDecorationState(_kError);
}
