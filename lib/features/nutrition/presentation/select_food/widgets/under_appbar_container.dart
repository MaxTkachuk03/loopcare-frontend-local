import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class UnderAppBarContainer extends StatelessWidget {
  final TabController tabController;

  const UnderAppBarContainer({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return Container(
          color: AppColors.greenRegular,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => _onSearchTap(context),
                child: IgnorePointer(
                  child: CustomTextField.search(
                    controller: TextEditingController(),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomUnderlinedTabBar(
                      labelColor: AppColors.blueDarker,
                      unselectedLabelColor: AppColors.blueDarker,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(text: LocalizedTexts.myFavorites.tr()),
                        Tab(text: LocalizedTexts.myDishes.tr()),
                      ],
                      tabController: tabController,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.router.pushNamed(AppRoutes.barcodeScanner);
                      },
                      icon: const ImageIcon(AppIcons.scan, color: AppColors.blueDarker),
                      label: CustomText.w400(LocalizedTexts.scan.tr()),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        minimumSize: const Size(0, 0),
                        foregroundColor: AppColors.blueDarker,
                        textStyle: context.textTheme.bodyMedium,
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
          final mealId = mealBloc.state.data.getCurrentMealId;
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
