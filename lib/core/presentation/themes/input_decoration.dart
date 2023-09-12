import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const Color _kEnabledText = AppColors.darkGreen;
const Color _kFocused = AppColors.redFocus;
const Color _kDisabledText = AppColors.grey;
const Color _kDisabled = AppColors.greyDisable;
const Color _kError = AppColors.redFocus;
const Color _kHint = AppColors.grey;

class AppInputDecoration extends InputDecoration {
  final BuildContext context;

  AppInputDecoration({
    required this.context,
    InputDecorationState state = InputDecorationState.enable,
    String? labelText,
    Widget? suffixIcon,
    int? errorMaxLines,
    String? hintText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
  }) : super(
          border: const OutlineInputBorder(),
          focusColor: _kFocused,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: state.color.withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kFocused),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kError),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: _kError,
              width: 2.0,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kDisabled),
          ),
          filled: false,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _kHint,
                fontSize: ThemeConstants.fontSize16,
              ),
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: state.color,
                fontSize: ThemeConstants.fontSize16,
              ),
          errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _kError,
                fontSize: ThemeConstants.fontSize12,
              ),
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          suffixIcon: suffixIcon,
          errorMaxLines: errorMaxLines,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
          counterText: '',
          alignLabelWithHint: true,
        );

  AppInputDecoration.counter({
    required this.context,
    InputDecorationState state = InputDecorationState.enable,
    String? labelText,
    Widget? suffixIcon,
    int? errorMaxLines,
    String? hintText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    String counterText = "",
  }) : super(
          counterText: counterText,
          border: const OutlineInputBorder(),
          focusColor: _kFocused,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: state.color.withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kFocused),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kError),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: _kError,
              width: 2.0,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _kDisabled),
          ),
          filled: false,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _kHint,
                fontSize: ThemeConstants.fontSize16,
              ),
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: state.color,
                fontSize: ThemeConstants.fontSize16,
              ),
          errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _kError,
                fontSize: ThemeConstants.fontSize12,
              ),
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          suffixIcon: suffixIcon,
          errorMaxLines: errorMaxLines,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
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
