import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/search_field.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_tab_bar.dart';

class UnderAppBarContainer extends StatelessWidget {
  const UnderAppBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return Container(
          color: state.isPlanningMeals
              ? AppColors.darkGreen
              : AppColors.blueAppBar,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              SizedBox(
                height: 38,
                child: InkWell(
                  onTap: () => _onSearchTap(context),
                  child: IgnorePointer(
                    child: SearchField(
                      readOnly: true,
                      hintText: LocalizedTexts.searchHint.translation,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16.0),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.greyLabel,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                height: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: UnderlinedTabBar(
                        tabs: [
                          Tab(text: LocalizedTexts.myFavorites.translation),
                          Tab(text: LocalizedTexts.myDishes.translation),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.router.pushNamed(AppRoutes.barcodeScanner);
                      },
                      icon: const ImageIcon(AppIcons.scan),
                      label: Text(LocalizedTexts.scan.translation),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        minimumSize: const Size(0, 0),
                        foregroundColor: AppColors.white,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }

  _onSearchTap(BuildContext context) {
    context.router.push(
      SearchRoute(
        onItemTap: (SearchItem item) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.getCurrentMealId;

          if (mealId == null) return;

          context.read<SearchBloc>().add(
                SearchEvent.addSearchResult(item.name),
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
