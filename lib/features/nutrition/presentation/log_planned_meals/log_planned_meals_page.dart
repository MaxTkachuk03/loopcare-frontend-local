import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_card.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_carousel.dart';

class LogPlannedMeals extends StatelessWidget {
  const LogPlannedMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(isCustomLeading: false),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 28.0,
            ),
            Expanded(child: PlannedMealCarousel()),
          ],
        ),
      ),
    );
  }
}
