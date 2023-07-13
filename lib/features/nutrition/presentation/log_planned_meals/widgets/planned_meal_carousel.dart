import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_card.dart';

class PlannedMealCarousel extends StatefulWidget {
  const PlannedMealCarousel({Key? key}) : super(key: key);

  @override
  _PlannedMealCarouselState createState() => _PlannedMealCarouselState();
}

class _PlannedMealCarouselState extends State<PlannedMealCarousel> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: 3,
            controller: PageController(viewportFraction: .9),
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: PlannedMealCard(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3]
              .mapIndexed(
                (index, el) => Hexagon(
                  width: 16,
                  height: 16,
                  borderRadius: 4.0,
                  innerWidget: Container(
                    color: currentPage == index ? AppColors.blueMid : AppColors.yellowLight,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
