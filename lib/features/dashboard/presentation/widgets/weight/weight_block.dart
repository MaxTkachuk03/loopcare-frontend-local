import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/weight_conversion_utils.dart';

class WeightBlock extends StatelessWidget {
  final DateTime date;

  const WeightBlock({super.key, required this.date});

  void onPressHandler(BuildContext context) =>
      context.router.push(LogWeightRoute(selectedDay: date));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocConsumer<DashboardWeightBloc, DashboardWeightState>(
        listener: (BuildContext context, state) {
          state.maybeWhen(
            error: (_) => context
                .read<DashboardWeightBloc>()
                .add(DashboardWeightEvent.fetchWeights(date.toUtc().toIso8601String())),
            orElse: () => null,
          );
        },
        builder: (BuildContext context, state) {
          return state.maybeMap(
            updated: (s) {
              final weightValue = s.data.getSelectedDayWeight(date.isoStringWithoutTime);
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

              return Row(
                children: [
                  AppIcons.customDashboardWeight,
                  const SizedBox(width: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.bitter600(
                        text,
                        style: context.textTheme.headlineSmall!.copyWith(
                          color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                        ),
                      ),
                      if (showSubText)
                        CustomText.w400(
                          LocalizedTexts.preferableInTheMorning.translation,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                          ),
                        )
                    ],
                  ),
                  const Spacer(),
                  if (isEditable)
                    CustomOutlinedRoundedButtonWithIcon(
                      onPressed: () => onPressHandler(context),
                      icon: hasLog ? AppIcons.edit : AppIcons.plus,
                    ),
                ],
              );
            },
            loading: (_) => const Loader(),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
