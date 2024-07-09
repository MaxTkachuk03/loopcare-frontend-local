import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';

class WeightBlock extends StatelessWidget {
  final DateTime date;

  const WeightBlock({super.key, required this.date});

  void onPressHandler(BuildContext context) =>
      context.router.push(LogWeightRoute(selectedDay: date));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocConsumer<DashboardWeightBloc, DashboardWeightState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (_) => context
                .read<DashboardWeightBloc>()
                .add(DashboardWeightEvent.fetchWeights(date.toUtc().toIso8601String())),
          );
        },
        builder: (context, state) {
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
                  ? "${LocalizedTexts.weight.tr()} : $inputWeightValue ${s.userWeightUnits}"
                  : isEditable
                      ? LocalizedTexts.logYourWeight.tr()
                      : LocalizedTexts.noWeightLogged.tr();

              final showSubText = !hasLog && isEditable;

              return DashboardCardTitle(
                onTap: () => onPressHandler(context),
                highlightColor: AppColors.coralLightest,
                leadingIcon: AppIcons.customDashboardWeight,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText.bitter600(
                      text,
                      style: context.textTheme.headlineSmall!.copyWith(
                        color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                      ),
                    ),
                    if (showSubText)
                      CustomText.w400(
                        LocalizedTexts.preferableInTheMorning.tr(),
                        style: context.textTheme.bodySmall!.copyWith(
                          color: isEditable ? AppColors.blueDarker : AppColors.greyLabel,
                        ),
                      ),
                  ],
                ),
                actionIcon: hasLog ? AppIcons.edit : AppIcons.plus,
                editable: isEditable,
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
