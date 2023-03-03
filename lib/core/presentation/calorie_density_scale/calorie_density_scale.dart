import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_dencity_scale_layout.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/widgets/scale_item/scale_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CalorieDensityScale extends StatelessWidget {
  final double density;
  final CalorieDensityScaleLayout layout;
  final Color
      separatorColor; // should be the same color as components bg to make it transparent
  final bool _useHorizontal;

  const CalorieDensityScale({
    Key? key,
    required this.density,
    required this.layout,
    required this.separatorColor,
  })  : _useHorizontal =
            layout == CalorieDensityScaleLayout.horizontal ? true : false,
        super(key: key);

  List<Widget> _renderListItems() {
    return calorieDensityScaleValues
        .map((range) => ScaleItem(
              range: range,
              density: density,
              useHorizontalLayout: _useHorizontal,
              separatorColor: separatorColor,
            ))
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
            AppColors.caloriesDensityGradiendStart,
            AppColors.caloriesDensityGradiendMid,
            AppColors.caloriesDensityGradiendEnd,
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
