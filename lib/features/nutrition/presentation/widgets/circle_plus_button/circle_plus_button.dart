import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

class CirclePlusButton extends StatelessWidget {
  const CirclePlusButton(
      {super.key, this.color, this.onPressed, this.width, this.icon, this.iconColor});

  final Color? color;
  final void Function()? onPressed;
  final double? width;
  final AssetImage? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomOutlinedRoundedButtonWithIcon(
          onPressed: onPressed ?? () => _onSearchTap(context),
          icon: icon ?? AppIcons.plus,
          bgColor: color,
          iconColor: iconColor,
        ),
        SizedBox(width: width ?? 16.0),
      ],
    );
  }

  _onSearchTap(BuildContext context) {
    context.router.push(
      SearchRoute(
        onItemTap: (SearchItem item) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.data.getCurrentMealId;
          if (mealId == null) {
            return;
          }

          if (item.type == SearchItemTypes.food) {
            context.router.push(
              SelectServingRoute(
                foodItemId: item.id,
                foodItemName: item.name,
                initialServingAmount: 1,
                onConfirm: (double numberOfUnits, String servingId) {
                  final mealId = mealBloc.state.data.getCurrentMealId;
                  if (mealId != null) {
                    mealBloc.add(
                      MealsEvent.addFoodItemToMeal(
                        mealId,
                        item.id,
                        AddFoodItemToMealBody(
                          numberOfUnits: numberOfUnits,
                          servingId: servingId,
                        ),
                      ),
                    );

                    const AnalyticsEventService().logEvent(
                      eventName: AnalyticsEvents.foodLogged,
                      parameters: {
                        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
                        AnalyticsParameters.mealId: mealId.toString(),
                        AnalyticsParameters.foodItem: item.id,
                        AnalyticsParameters.servingId: servingId,
                        AnalyticsParameters.numberOfUnits: numberOfUnits.toString(),
                        AnalyticsParameters.isMeal: 'true',
                      },
                    );

                    context.router.pushNamed(AppRoutes.meal);
                  }
                },
              ),
            );
          } else if (item.type == SearchItemTypes.recipe) {
            context.router.push(
              RecipeRoute(
                id: int.parse(item.id),
                name: item.name,
              ),
            );
          } else if (item.type == SearchItemTypes.dish) {
            context.router.push(
              DishDetailsRoute(
                dishId: int.parse(item.id),
                canEditDish: false,
              ),
            );
          }
        },
      ),
    );
  }
}
