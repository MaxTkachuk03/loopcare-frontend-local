import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/widgets/scale_item/scale_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CalorieDensityScale extends StatelessWidget {
  final double? density;
  final CalorieDensityScaleLayout layout;
  final double? separatorSize;
  final Color separatorColor; // should be the same color as components bg to make it transparent
  final bool _useHorizontal;

  const CalorieDensityScale({
    Key? key,
    this.density,
    required this.layout,
    required this.separatorColor,
    this.separatorSize = 3,
  })  : _useHorizontal = layout == CalorieDensityScaleLayout.horizontal ? true : false,
        super(key: key);

  List<Widget> _renderListItems() {
    return calorieDensityScaleValues
        .map(
          (range) => ScaleItem(
            range: range,
            density: density,
            useHorizontalLayout: _useHorizontal,
            separatorColor: separatorColor,
            separatorSize: separatorSize,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: _useHorizontal ? Alignment.centerLeft : Alignment.bottomCenter,
          end: _useHorizontal ? Alignment.centerRight : Alignment.topCenter,
          colors: const [
            AppColors.caloriesDensityGradientStart,
            AppColors.caloriesDensityGradientMid,
            AppColors.caloriesDensityGradientEnd,
          ],
        ),
      ),
      child: _useHorizontal
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _renderListItems(),
            )
          : Column(
              verticalDirection: VerticalDirection.up,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _renderListItems(),
            ),
    );
  }
}
