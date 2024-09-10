import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';

class ListFilters extends StatelessWidget {
  final String title;
  final List<MealCategoryFilter> mealsList;
  final Function(List<MealCategoryFilter> updatedFiltersList) onConfirmed;

  const ListFilters({
    super.key,
    required this.title,
    required this.mealsList,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greenLighter,
      child: MainContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText.w600(
                title,
                style: context.textTheme.bodyMedium,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.blueDarker,
              ),
              onPressed: () => _onShowMy(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onShowMy(BuildContext context) {
    ModalBottomSheet.filterDialog(
      context: context,
      title: LocalizedTexts.showMy.tr(),
      onConfirmed: onConfirmed,
      list: mealsList,
    );
  }
}
