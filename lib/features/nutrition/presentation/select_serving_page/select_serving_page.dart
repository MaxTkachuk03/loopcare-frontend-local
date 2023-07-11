import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/favourite_btn/favourite_btn.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_category_filters_list/meal_category_filters_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_list/servings_list.dart';

class SelectServingPage extends StatefulWidget {
  final String foodItemId;
  final String? initialServingId;
  final String foodItemName;
  final double initialServingAmount;
  final double? initialCaloriesValue;
  final void Function(double numberOfUnits, String servingId) onConfirm;

  const SelectServingPage({
    Key? key,
    required this.foodItemId,
    required this.foodItemName,
    required this.initialServingAmount,
    required this.onConfirm,
    this.initialServingId,
    this.initialCaloriesValue,
  }) : super(key: key);

  @override
  State<SelectServingPage> createState() => _SelectServingPageState();
}

class _SelectServingPageState extends State<SelectServingPage> {
  @override
  void initState() {
    context.read<FoodItemServingsBloc>().add(
          FoodItemServingsEvent.fetchFoodItemServings(
            foodItemId: widget.foodItemId,
            selectedServingId: widget.initialServingId,
            initialServingAmount: widget.initialServingAmount,
            initialCaloriesValue: widget.initialCaloriesValue,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonHexagon(),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
            ),
        backgroundColor: AppColors.blueAppBar,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.foodItemName,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 21.0),
                      BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
                        builder: (BuildContext context, state) {
                          return state.maybeMap(
                            orElse: () => const SizedBox(
                              height: 48.0,
                              width: 32.0,
                            ),
                            error: (errorState) {
                              final error = errorState.fetchError;

                              return ErrorScreen(
                                error: error,
                                onButtonPressed: () => context.read<FoodItemServingsBloc>().add(
                                      FoodItemServingsEvent.fetchFoodItemServings(
                                        foodItemId: widget.foodItemId,
                                        selectedServingId: widget.initialServingId,
                                        initialServingAmount: widget.initialServingAmount,
                                        initialCaloriesValue: widget.initialCaloriesValue,
                                      ),
                                    ),
                              );
                            },
                            foodItemServings: (foodItemServingsState) {
                              if (foodItemServingsState.selectedServing == null) {
                                return const SizedBox.shrink();
                              }

                              return FavouriteBtn(
                                isActive: foodItemServingsState.selectedServing?.isSelectedFavorite ?? false,
                                onPress: _onFavouritePressed,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: ServingList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: ElevatedButton(
              onPressed: () => _onConfirmPressed(context),
              child: Text(
                LocalizedTexts.confirm.translation,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onConfirmPressed(BuildContext context) {
    final state = context.read<FoodItemServingsBloc>().state;

    final servingAmount = state.selectedServingAmount;
    final servingId = state.selectedServingItem?.servingId;

    if (servingAmount != null && servingId != null) {
      widget.onConfirm.call(double.parse(servingAmount), servingId);
    }
    context.router.pop();
  }

  String _getSnackBarText(bool isFavorite, bool hasActiveFilters) {
    return isFavorite && !hasActiveFilters
        ? LocalizedTexts.removedFromFavorites.translation
        : LocalizedTexts.addedToFavorites.translation;
  }

  _showSnackBar() {
    final state = context.read<FoodItemServingsBloc>().state;

    final isFavorite = state.selectedServingItem?.isSelectedFavorite ?? false;

    final snackBarText = _getSnackBarText(isFavorite, state.hasSelectedMealCategoryFilters);

    showAppSnackBar(
      context: context,
      text: snackBarText,
      background: Colors.white,
      textColor: Colors.black,
    );
  }

  _removeFromFavorite() {
    final bloc = context.read<FoodItemServingsBloc>();

    final id = bloc.state.selectedServingItem?.servingId;

    if (id == null) return;

    bloc.add(FoodItemServingsEvent.removeFromFavorites(
      widget.foodItemId,
      id,
    ));
  }

  _addToFavorite() {
    context.read<FoodItemServingsBloc>().add(FoodItemServingsEvent.addToFavorites(widget.foodItemId));
  }

  _updateFavourite() {
    context.read<FoodItemServingsBloc>().add(FoodItemServingsEvent.updateFavorite(widget.foodItemId));
  }

  _onAddAsFavouriteConfirmedPressed() {
    final state = context.read<FoodItemServingsBloc>().state;

    final isFavorite = state.selectedServingItem?.isSelectedFavorite ?? false;

    if (!state.hasSelectedMealCategoryFilters && !isFavorite) {
      return;
    }

    if (isFavorite) {
      state.hasSelectedMealCategoryFilters ? _updateFavourite() : _removeFromFavorite();
    } else {
      _addToFavorite();
    }

    _showSnackBar();

    context.router.pop();
  }

  void _onFavouriteFilterPressed(
    BuildContext context,
    bool value,
    String name,
  ) {
    context.read<FoodItemServingsBloc>().add(FoodItemServingsEvent.updateMealCategoryFilter(value, name));
  }

  void _onFavouritePressed() {
    final state = context.read<FoodItemServingsBloc>().state;

    final title = state.selectedServingItem?.isSelectedFavorite ?? false
        ? LocalizedTexts.removeFromFavorites.translation
        : LocalizedTexts.addAsFavourite.translation;

    final subTitle = '${widget.foodItemName} serving: ${state.selectedServingItem?.servingLabel}';

    context.read<FoodItemServingsBloc>().add(FoodItemServingsEvent.setMealCategoryFilters(
          state.filtersForSelectedServing,
        ));

    ModalBottomSheet.filterDialogFavorites(
      context: context,
      title: title,
      subtitle: subTitle,
      onConfirmed: _onAddAsFavouriteConfirmedPressed,
      listWidget: MealCategoryFiltersList(
        onFilterPressed: _onFavouriteFilterPressed,
      ),
    );
  }
}
