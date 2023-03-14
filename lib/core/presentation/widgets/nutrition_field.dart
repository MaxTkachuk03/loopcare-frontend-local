import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class NutritionField extends StatelessWidget {
  final bool readOnly;
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;

  const NutritionField({
    Key? key,
    this.readOnly = false,
    required this.hintText,
    this.contentPadding,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: AppColors.greyLabel,
            ),
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyMid, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
