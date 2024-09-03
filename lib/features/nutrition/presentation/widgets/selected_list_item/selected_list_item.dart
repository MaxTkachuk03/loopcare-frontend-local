import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_input_field/serving_input_field.dart';

class SelectedListItem extends StatelessWidget {
  final ServingSize item;
  final TextEditingController inputController;
  final void Function(ServingSize item) onPressed;

  const SelectedListItem({
    super.key,
    required this.item,
    required this.onPressed,
    required this.inputController,
  });

  void _onAmountChange(BuildContext context, String value) {
    final String amount = value.isEmpty ? '0' : value;

    context
        .read<FoodItemServingsBloc>()
        .add(FoodItemServingsEvent.setSelectedServingAmount(amount));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Container(
        height: 86,
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check,
              color: AppColors.greenRegular,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomText.w600(
                item.servingLabel,
                maxLines: 2,
                style: context.textTheme.bodySmall?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Column(
              children: [
                CustomText.w400(
                  LocalizedTexts.amount.tr(),
                  style: context.textTheme.bodySmall,
                ),
                Expanded(
                  child: Center(
                    child: ServingInputField(
                      controller: inputController,
                      fillColor: AppColors.white,
                      onChange: (value) => _onAmountChange(context, value),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6),
            Column(
              children: [
                CustomText.w400(
                  LocalizedTexts.calories.tr(),
                  style: context.textTheme.bodySmall,
                ),
                Expanded(
                  child: Center(
                    child: BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
                      builder: (context, state) {
                        return CustomText.w600(
                          '${state.selectedServingCalories} ${LocalizedTexts.kcal.tr()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
