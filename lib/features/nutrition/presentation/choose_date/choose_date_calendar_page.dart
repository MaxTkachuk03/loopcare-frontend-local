import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/widgets/week_calendar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

@RoutePage()
class ChooseDateCalendarPage extends StatefulWidget {
  final String mealCategory;
  final List<DateTime>? dates;
  final int mealId;

  const ChooseDateCalendarPage({
    super.key,
    required this.mealCategory,
    required this.dates,
    required this.mealId,
  });

  @override
  State<ChooseDateCalendarPage> createState() => _ChooseDateCalendarPageState();
}

class _ChooseDateCalendarPageState extends State<ChooseDateCalendarPage> {
  bool isShowReplaceWarning = false;

  @override
  void initState() {
    super.initState();

// TODO: LOOPCARE-1798 Hide Meal planning block
    // context.read<ChooseDateBloc>().add(
    //       ChooseDateEvent.getPlannedMeals(
    //         DateTime.now(),
    //         DateTime.now().add(
    //           const Duration(days: 15),
    //         ),
    //       ),
    //     );

    context.read<ChooseDateBloc>().add(
          ChooseDateEvent.setData(
            mealCategory: widget.mealCategory,
            dates: widget.dates,
            currentMealId: widget.mealId,
          ),
        );
  }

  _errorListener(BuildContext context, ChooseDateState state) {
    if (state.data.showSaveWarning) {
      context.showFlashBar(
        text: LocalizedTexts.saveDateError.tr(),
        leadIcon: Hexagon(
          width: 54,
          height: 54,
          borderRadius: 18,
          innerWidget: Container(
            color: AppColors.white,
            child: Container(
              color: AppColors.blueDark,
              child: AppImages.exclamationMark,
            ),
          ),
        ),
      );
    }
    if (state.data.showReplaceWarning && !isShowReplaceWarning) {
      isShowReplaceWarning = true;
      final mealsState = context.read<MealsBloc>().state;

      ModalBottomSheet.replacePlannedMeal(
        context: context,
        onBtnPressed: () => _onReplacePressHandler(state.data.getWarningDate, context),
        onClose: () => isShowReplaceWarning = false,
        date: state.data.getWarningDate.shortDate,
        mealCategory: widget.mealCategory,
        oldItem: state.data.plannedMealsForWarningDate.first,
        newItem: mealsState.data.currentMeal,
      );
    }
  }

  void _onReplacePressHandler(DateTime date, BuildContext context) {
    isShowReplaceWarning = false;
    context
      ..read<ChooseDateBloc>().add(
        ChooseDateEvent.selectDate(
          [date],
          confirmed: true,
        ),
      )
      ..router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseDateBloc, ChooseDateState>(
      listenWhen: (prev, cur) => (cur.data.showSaveWarning || cur.data.showReplaceWarning),
      listener: _errorListener,
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
              body: CustomSafeArea(
                child: ScrollableContainer(
                  child: Column(
                    children: [
                      CustomAppBar.green(
                        title: LocalizedTexts.chooseDateFor.tr(
                          {'mealCategory': widget.mealCategory},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              LocalizedTexts.youCanChangeTheDate.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 26.0),
                            const ChooseDateCalendar(),
                            const SizedBox(height: 26.0),
                            MainContainer(
                              child: ElevatedButton(
                                onPressed: () =>
                                    state.data.canSave ? _onSaveChangesPressed(context) : null,
                                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      if (state.data.canSave) {
                                        return AppColors.blueDark;
                                      }

                                      return AppColors.greyMid;
                                    },
                                  ),
                                ),
                                child: Text(LocalizedTexts.saveChanges.tr()),
                              ),
                            ),
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
    // final mealsBloc = context.read<MealsBloc>();
    // final chooseDateBloc = context.read<ChooseDateBloc>();
// TODO removed feature
    // mealsBloc.add(
    //   MealsEvent.updatePlannedMeal(
    //     chooseDateBloc.state.data.currentMealId,
    //     chooseDateBloc.state.data.selectedDateList,
    //   ),
    // );

    context.router.maybePop();
    context.showSuccessBar(
      content: CustomText(LocalizedTexts.changesSaved.tr()),
    );

    context.showFlashBar(
      text: LocalizedTexts.changesSaved.tr(),
      leadIcon: Hexagon(
        width: 54,
        height: 54,
        borderRadius: 18,
        innerWidget: Container(
          color: AppColors.white,
          child: Container(
            color: AppColors.blueDark,
            child: AppImages.exclamationMark,
          ),
        ),
      ),
    );
  }
}
