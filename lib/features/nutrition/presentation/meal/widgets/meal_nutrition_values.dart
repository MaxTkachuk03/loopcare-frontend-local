import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class MealNutritionValues extends StatelessWidget {
  const MealNutritionValues({super.key});

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizedTexts.total.translation.capitalizeOnlyFirstLetter(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            InkWell(
              onTap: () => _onTap(context),
              child: Row(
                children: [
                  BlocBuilder<MealsBloc, MealsState>(
                    builder: (BuildContext context, state) {
                      return state.currentMealServing?.calories != null
                          ? Text(
                              '${state.currentMealServing?.calories} kcal',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            )
                          : Text(
                              '0 kcal',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            );
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const SizedBox(
                    width: 12,
                    height: 16,
                    child: ImageIcon(
                      AppIcons.arrow,
                      color: AppColors.greyLabel,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    ModalBottomSheet.nutrientFactsDialog(
      context: context,
      list: <NutritionItem>[],
      onSelect: (NutritionItem item) {},
    );
  }
}
