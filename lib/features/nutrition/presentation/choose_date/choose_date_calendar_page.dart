import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loopcare_frontend/core/presentation/app_bar/green_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/widgets/week_calendar.dart';

import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class ChooseDateCalendarPage extends StatefulWidget {
  final String mealCategory;
  final DateTime? date;

  const ChooseDateCalendarPage({
    Key? key,
    required this.mealCategory,
    required this.date,
  }) : super(key: key);

  @override
  State<ChooseDateCalendarPage> createState() => _ChooseDateCalendarPageState();
}

class _ChooseDateCalendarPageState extends State<ChooseDateCalendarPage> {
  @override
  void initState() {
    super.initState();

    context.read<ChooseDateBloc>().add(
          ChooseDateEvent.setData(
            mealCategory: widget.mealCategory,
            date: widget.date,
          ),
        );
  }

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
            return Scaffold(
              body: SafeArea(
                top: false,
                child: ScrollableContainer(
                  child: Column(
                    children: [
                      GreenAppBar(
                        title: LocalizedTexts.chooseDateFor.tr(
                          namedArgs: {'mealCategory': widget.mealCategory},
                        ),
                        darkGreen: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              LocalizedTexts.youCanChangeTheDate,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                            const SizedBox(height: 26.0),
                            const ChooseDateCalendar(),
                            const SizedBox(height: 26.0),
                            MainContainer(
                              child: ElevatedButton(
                                onPressed: () => _onSaveChangesPressed(context),
                                child: Text(LocalizedTexts.saveChanges.translation),
                              ),
                            ),
                            // const SizedBox(height: 20.0)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () => const Scaffold(
            body: SizedBox.shrink(),
          ),
        );
      },
    );
  }

  _onSaveChangesPressed(BuildContext context) {
    context.router.push(SelectFoodRoute(mealCategory: widget.mealCategory));
  }
}
