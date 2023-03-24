import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ScaleItem extends StatelessWidget {
  final Range range;
  final double density;
  final Color separatorColor;
  final bool useHorizontalLayout;
  final double minimalPossibleValue = 0.99;
  final double? separatorSize;

  const ScaleItem({
    Key? key,
    required this.range,
    required this.density,
    required this.useHorizontalLayout,
    required this.separatorColor,
    this.separatorSize,
  }) : super(key: key);

  Widget _renderSeparator() {
    return Container(
      color: separatorColor,
      width: useHorizontalLayout ? separatorSize : null,
      height: useHorizontalLayout ? null : separatorSize,
    );
  }

  bool _isDensityInRange() {
    return (range.min <= density && density <= range.max) ||
        density >= range.max;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      alignment:
          useHorizontalLayout ? Alignment.centerRight : Alignment.topCenter,
      children: [
        Container(
          color:
              _isDensityInRange() ? Colors.transparent : AppColors.yellowLight,
        ),
        _renderSeparator(),
      ],
    ));
  }
}
