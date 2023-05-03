import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

class SearchResultListItem extends StatelessWidget {
  final SearchItem item;

  const SearchResultListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _onTap(context),
        child: Ink(
          color: AppColors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 15),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                item.type.icon,
                                color: AppColors.blueMid,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(width: 12.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                  color: AppColors.yellowLight, height: 1, thickness: 1),
            ],
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    var mealBloc = context.read<MealsBloc>();
    var mealId = mealBloc.state.getCurrentMealId;
    if (mealId != null) {
      if (item.type == SearchItemTypes.recipe) {
        mealBloc.add(
          MealsEvent.addRecipeToMeal(
            mealId,
            item.id,
          ),
        );
      } else if (item.type == SearchItemTypes.dish) {
        mealBloc.add(
          MealsEvent.addDishToMeal(
            mealId,
            item.id,
          ),
        );
      }
    }

    context.router.pushNamed(AppRoutes.meal);
  }
}
