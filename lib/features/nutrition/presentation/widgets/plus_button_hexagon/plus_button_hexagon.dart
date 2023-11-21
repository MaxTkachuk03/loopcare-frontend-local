import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';

class PlusButtonHexagon extends StatelessWidget {
  const PlusButtonHexagon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hexagon(
          width: 54,
          height: 54,
          borderRadius: 18,
          innerWidget: Container(
            color: AppColors.white,
            child: IconButton(
              icon: const ImageIcon(
                AppIcons.plus,
                color: AppColors.blueMid,
                size: 18,
              ),
              onPressed: () => _onSearchTap(context),
            ),
          ),
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

                    context.router.pushNamed(AppRoutes.meal);
                  } else {
                    print('Search item click freezed PlusButtonHexagon mealId == null line 79');
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
          } else {
            print('Search item click freezed PlusButtonHexagon line 99');
          }
        },
      ),
    );
  }
}
