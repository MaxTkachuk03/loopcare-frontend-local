import 'dart:io';
import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool? bottom;

  const CustomSafeArea({super.key, required this.child, this.top = true, this.bottom});

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: top, bottom: bottom ?? Platform.isAndroid, child: child);
  }
}
