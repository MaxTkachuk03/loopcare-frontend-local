import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/barcode_scanner_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class ProductInformation extends StatelessWidget {
  final String title;
  final String calories;
  final String perServing;
  final bool isReady;

  const ProductInformation({
    super.key,
    required this.title,
    required this.calories,
    required this.perServing,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
              CustomIconButton.close(onPressed: context.router.maybePop)
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (isReady)
                CustomText.bitter600(
                  title,
                  style: context.textTheme.bodyLarge,
                ),
              const SizedBox(height: 8),
              if (isReady)
                CustomText.w400(
                  '${LocalizedTexts.barCodeResultCalories.tr()} $calories',
                  style: context.textTheme.bodyMedium,
                ),
              if (isReady)
                CustomText.w400(
                  '${LocalizedTexts.barCodeResultPerServing.tr()} $perServing',
                  style: context.textTheme.bodyMedium,
                ),
            ],
          ),
        ),
        CustomOutlinedButton.blueFullWidth(
          onPressed: context.router.maybePop,
          label: LocalizedTexts.scanOtherProduct.tr(),
        ),
        const SizedBox(height: 14),
        CustomElevatedButton.blueFullWidth(
          onPressed: () => _onContinue(context),
          label: LocalizedTexts.continueBtn.tr(),
        ),
      ],
    );
  }

  void _onContinue(BuildContext context) {
    final foodItem = context.read<BarcodeScannerBloc>().state.mapOrNull(success: (state) => state.foodItem);

    if (foodItem == null) return;

    final serving = foodItem.servings.first;

    final servingId = serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: foodItem.id,
        initialServingId: servingId,
        initialServingAmount: serving.numberOfUnits,
        foodItemName: foodItem.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.data.getCurrentMealId;
          if (mealId != null) {
            mealBloc.add(
              MealsEvent.addFoodItemToMeal(
                mealId,
                foodItem.id,
                AddFoodItemToMealBody(
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              ),
            );

            AnalyticsEventService.instance.logEvent(
              FirebaseEvents.foodLogged,
              parameters: {
                CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                CustomDefinitions.mealId: mealId.toString(),
                CustomDefinitions.foodItem: foodItem.id,
                CustomDefinitions.servingId: servingId,
                CustomDefinitions.numberOfUnits: numberOfUnits.toString(),
                CustomDefinitions.isMeal: 'true',
              },
            );
            context.router.pushNamed(AppRoutes.meal);
          }
        },
      ),
    );
  }
}
