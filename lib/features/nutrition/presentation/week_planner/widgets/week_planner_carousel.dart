import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_card.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/selected_day_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class WeekPlannerCarousel extends StatefulWidget {
  const WeekPlannerCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _WeekPlannerCarouselState();
}

class _WeekPlannerCarouselState extends State<WeekPlannerCarousel> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage, viewportFraction: .85);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseDateBloc, ChooseDateState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: state.data.plannedMealsForSelectedWeek.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SelectedDayList(
                      mealsListItems: state.data.plannedMealsForSelectedWeek[index],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: state.data.plannedMealsForSelectedWeek
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
      },
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
