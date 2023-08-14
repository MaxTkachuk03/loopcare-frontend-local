import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ScaleItem extends StatelessWidget {
  final Range range;
  final double? density;
  final Color separatorColor;
  final bool useHorizontalLayout;
  final double minimalPossibleValue = 0.99;
  final double? separatorSize;
  final bool isLastElement;

  const ScaleItem({
    Key? key,
    required this.range,
    this.density,
    required this.useHorizontalLayout,
    required this.separatorColor,
    this.separatorSize,
    required this.isLastElement,
  }) : super(key: key);

  Widget _renderSeparator() {
    return Container(
      color: separatorColor,
      width: useHorizontalLayout ? separatorSize : null,
      height: useHorizontalLayout ? null : separatorSize,
    );
  }

  Widget _horizontalCell(bool isDensityInRange) {
    return Column(
      children: [
        Container(color: Colors.transparent, height: 5),
        Expanded(
          child: Container(
            color: isDensityInRange ? Colors.transparent : AppColors.yellowLight,
          ),
        ),
      ],
    );
  }

  Widget _verticalCell(bool isDensityInRange) {
    return Container(
      color: isDensityInRange ? Colors.transparent : AppColors.yellowLight,
    );
  }

  bool _isDensityInRange(bool useHorizontalLayout) {
    final density = this.density;

    if (density == null) return false;
    if (useHorizontalLayout) {
      return isLastElement
          ? (range.min <= density && density <= range.max) || density >= range.max
          : (range.min <= density && density <= range.max);
    } else {
      return (range.min <= density && density <= range.max) || density >= range.max;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: useHorizontalLayout ? Alignment.centerRight : Alignment.topCenter,
        children: [
          useHorizontalLayout
              ? _horizontalCell(_isDensityInRange(useHorizontalLayout))
              : _verticalCell(_isDensityInRange(useHorizontalLayout)),
          _renderSeparator(),
        ],
      ),
    );
  }
}
