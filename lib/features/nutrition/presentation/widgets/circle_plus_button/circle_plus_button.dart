import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';

class CirclePlusButton extends StatelessWidget {
  const CirclePlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomOutlinedRoundedButtonWithIcon(
          onPressed: () => _onSearchTap(context),
          icon: AppIcons.plus,
          bgColor: AppColors.greenLighter,
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  _onSearchTap(BuildContext context) {
    context.router.push(
      SearchRoute(
        onItemTap: (SearchItem item) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.getCurrentMealId;

          if (mealId == null) {
            return;
          }

          context.read<SearchBloc>().add(
                SearchEvent.addSearchResult(item.name, item.type.searchModeValue),
              );

          if (item.type == SearchItemTypes.food) {
            context.router.push(
              SelectServingRoute(
                foodItemId: item.id,
                foodItemName: item.name,
                initialServingAmount: 1,
                onConfirm: (double numberOfUnits, String servingId) {
                  final mealId = mealBloc.state.getCurrentMealId;
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

                    AnalyticsEventService.instance.logEvent(
                      FirebaseEvents.foodLogged,
                      parameters: {
                        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                        CustomDefinitions.mealId: mealId.toString(),
                        CustomDefinitions.foodItem: item.id,
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
