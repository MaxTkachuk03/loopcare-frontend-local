import 'package:flutter/material.dart';

extension ScrollControllerExtension on ScrollController {
  Future<void> scrollWithEase600(double offset) =>
      animateTo(offset, duration: const Duration(milliseconds: 600), curve: Curves.ease);
}
