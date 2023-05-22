import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

class WeightBlock extends StatelessWidget {
  final DateTime date;

  const WeightBlock({
    Key? key,
    required this.date,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    context.router.push(LogWeightRoute(selectedDay: date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Image(image: AppIcons.dashboardWeight),
              const SizedBox(width: 24.0),
              BlocBuilder<DashboardWeightBloc, DashboardWeightState>(
                  builder: (BuildContext context, state) {
                return state.maybeMap(
                  weights: (s) {
                    final weightValue =
                        s.getSelectedDayWeight(date.isoStringWithoutTime);
                    final bool isEditable = s.isEditable(date);
                    final hasLog = weightValue != null;

                    final inputWeightValue = s.isMetricSystem
                        ? weightValue
                        : WeightConversionUtils.convertKgToLbs(
                            weightValue ?? 0.0,
                          );

                    final text = hasLog
                        ? "${LocalizedTexts.weight.translation} : $inputWeightValue ${s.userWeightUnits}"
                        : isEditable
                            ? LocalizedTexts.logYourWeight.translation
                            : LocalizedTexts.noWeightLogged.translation;

                    final showSubText = !hasLog && isEditable;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                                color: isEditable
                                    ? AppColors.darkGreen
                                    : AppColors.greyLabel,
                              ),
                        ),
                        if (showSubText)
                          Text(
                            LocalizedTexts.preferableInTheMorning.translation,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.greyLabel),
                          )
                      ],
                    );
                  },
                  loading: (_) => const SizedBox(),
                  orElse: () => const SizedBox(),
                );
              }),
            ],
          ),
          BlocBuilder<DashboardWeightBloc, DashboardWeightState>(
              builder: (BuildContext context, s) {
            final bool isEditable = s.isEditable(date);
            final hasLog = s.hasLogOnSelectedDate(date);

            return isEditable
                ? Hexagon(
                    width: 54,
                    height: 54,
                    borderRadius: 16,
                    innerWidget: Container(
                      color: AppColors.bgGreen,
                      child: IconButton(
                        icon: ImageIcon(
                          hasLog ? AppIcons.edit : AppIcons.plus,
                          color: AppColors.darkGreen,
                          size: 18,
                        ),
                        onPressed: () => onPressHandler(context),
                      ),
                    ),
                  )
                : Container();
          }),
        ],
      ),
    );
  }
}
