import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class MealNutritionValues extends StatelessWidget {
  const MealNutritionValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizedTexts.totalEnergy.translation
                  .capitalizeOnlyFirstLetter(),
              style: Theme.of(context).textTheme.caption,
            ),
            InkWell(
              onTap: () => _onTap(context),
              child: Row(
                children: [
                  Text(
                    '560 kcal',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
      list: [1, 2],
      onSelect: (_) {},
    );
  }
}
