import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Field extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String hintText;
  final bool? obscureText;
  final AssetImage? prefixIcon;
  final bool? isToggleEye;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const Field({
    Key? key,
    this.keyboardType,
    this.controller,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.errorText,
    this.isToggleEye,
    this.validator,
    this.onChanged,
    this.contentPadding,
  }) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  bool _isObscureText = false;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final prefixIcon = widget.prefixIcon;

    return TextFormField(
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      obscureText: _isObscureText,
      decoration: InputDecoration(
        errorText: widget.errorText,
        contentPadding: widget.contentPadding,
        errorMaxLines: 2,
        hintText: widget.hintText,
        prefixIcon: prefixIcon != null ? ImageIcon(prefixIcon) : null,
        suffixIcon: widget.isToggleEye ?? false
            ? IconButton(
                icon: const ImageIcon(AppIcons.iconOpenEye),
                color: _isObscureText ? AppColors.greyMid : AppColors.darkGreen,
                onPressed: _toggleEye,
              )
            : null,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
    );
  }

  _toggleEye() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }
}
