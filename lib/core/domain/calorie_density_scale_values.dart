import 'package:flutter/material.dart';

class Range {
  final double min;
  final double max;
  final Color color;

  Range({required this.min, required this.max, required this.color});
}

final List<Range> calorieDensityScaleValues = [
  Range(min: 0, max: 1.0, color: const Color(0xFF24CB35)),
  Range(min: 1, max: 1.3, color: const Color(0xFF60BB3F)),
  Range(min: 1.3, max: 1.5, color: const Color(0xFF73B642)),
  Range(min: 1.5, max: 1.65, color: const Color(0xFF94AC48)),
  Range(min: 1.65, max: 1.75, color: const Color(0xFFCD9D52)),
  Range(min: 1.75, max: 1.90, color: const Color(0xFFE68A52)),
  Range(min: 1.90, max: 2.10, color: const Color(0xFFD96A44)),
  Range(min: 2.10, max: 2.30, color: const Color(0xFFCF5139)),
  Range(min: 2.30, max: 2.60, color: const Color(0xFFC94032)),
  Range(min: 2.60, max: 2.61, color: const Color(0xFFB7131E)),
];
