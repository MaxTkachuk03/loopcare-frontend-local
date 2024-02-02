import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SearchField extends StatelessWidget {
  final bool readOnly;
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final void Function(String value)? onChanged;

  const SearchField({
    super.key,
    this.readOnly = false,
    required this.hintText,
    this.contentPadding,
    this.prefixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      enableIMEPersonalizedLearning: false,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.greyLight,
            ),
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyRegular, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
