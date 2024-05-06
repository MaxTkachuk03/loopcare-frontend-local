import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/constants.dart';
import 'package:loopcare_frontend/core/domain/nutrition/calorie_budget.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/calorie_tracker/range_item.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/bmr/bmr_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

final account = getIt<SharedStorageService>().account;

class CaloriesTracker extends StatelessWidget {
  final double totalCalories;

  const CaloriesTracker({super.key, required this.totalCalories});

  String get _caloriesValue => totalCalories.toStringAsFixed(0);

  double get _caloriesMaintenanceIndex =>
      CalorieBudget.getNutritionActivityMultiplier(account?.trainingFrequency ?? 0);

  double _getCaloriesMaintenanceRatio(double caloriesMaintenance) {
    final ratio = totalCalories / caloriesMaintenance;

    return ratio.isNaN || ratio.isInfinite ? 0 : ratio;
  }

  double topOfCaloriesRange(double caloriesMaintenance) =>
      caloriesMaintenance - Constants.calorieMaintenanceTopRange;

  num bottomOfCaloriesRange(double caloriesMaintenance) {
    final double bottomRange = caloriesMaintenance - Constants.calorieMaintenanceBottomRange;

    return bottomRange < account!.minCalorieRangeValue ? account!.minCalorieRangeValue : bottomRange;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmrBloc, BmrState>(
      builder: (context, state) {
        return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              final double caloriesMaintenance = state.data.bmr * _caloriesMaintenanceIndex;

              return LayoutBuilder(builder: (context, constraints) {
                final pxToCaloriesRatio = caloriesMaintenance / constraints.maxWidth;
                final topRangeValue = topOfCaloriesRange(caloriesMaintenance);
                final bottomRangeValue = bottomOfCaloriesRange(caloriesMaintenance);
                final topRangePosition = topRangeValue / pxToCaloriesRatio;
                final bottomRangePosition = bottomRangeValue / pxToCaloriesRatio;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        RangeItem(position: topRangePosition, label: topRangeValue.toStringAsFixed(0)),
                        RangeItem(position: bottomRangePosition, label: bottomRangeValue.toStringAsFixed(0)),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(color: AppColors.white, style: BorderStyle.solid),
                          ),
                        ),
                        LinearProgressIndicator(
                          minHeight: 15.0,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blueRegular),
                          backgroundColor: AppColors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          value: _getCaloriesMaintenanceRatio(caloriesMaintenance),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CustomText.w600(
                      '$_caloriesValue ${LocalizedTexts.calories.tr().toLowerCase()}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                );
              });
            });
      },
    );
  }
}
