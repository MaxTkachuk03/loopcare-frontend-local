import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/widgets/week_element.dart';

import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class ChooseDateCalendar extends StatelessWidget {
  const ChooseDateCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseDateBloc, ChooseDateState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loading: (_) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButtonHexagon(
                  background: AppColors.white.withOpacity(0.2),
                ),
              ),
              body: const Loader(),
            );
          },
          calendar: (s) {
            return Column(
              children: s.data.weekDayElementList.entries
                  .map((entry) => WeekElement(
                        weekNumber: entry.key,
                        weekElements: entry.value,
                        onPressHandler: (DateTime date) => onPressHandler(date, context),
                      ))
                  .toList(),
            );
          },
          orElse: () => const Scaffold(
            body: SizedBox.shrink(),
          ),
        );
      },
    );
  }

  void onPressHandler(DateTime date, BuildContext context) {
    context.read<ChooseDateBloc>().add(
          ChooseDateEvent.selectDate([date]),
        );
  }
}
