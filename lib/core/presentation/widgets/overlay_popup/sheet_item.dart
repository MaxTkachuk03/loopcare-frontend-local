import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SheetItem {
  final String title;
  final SvgPicture? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool? isExpandable;

  SheetItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.isExpandable = false,
  });
}
