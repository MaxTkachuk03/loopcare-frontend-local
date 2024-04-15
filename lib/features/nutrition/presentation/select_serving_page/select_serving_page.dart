import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/favourite_btn/favourite_btn.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_category_filters_list/meal_category_filters_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_list/servings_list.dart';

const double _kBottomPreferredHeight = 72;

class SelectServingPage extends StatefulWidget {
  final String foodItemId;
  final String? initialServingId;
  final String foodItemName;
  final double initialServingAmount;
  final double? initialCaloriesValue;
  final void Function(double numberOfUnits, String servingId) onConfirm;

  const SelectServingPage({
    super.key,
    required this.foodItemId,
    required this.foodItemName,
    required this.initialServingAmount,
    required this.onConfirm,
    this.initialServingId,
    this.initialCaloriesValue,
  });

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
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.logMealServingTitle.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
        actions: [
          BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => const SizedBox(
                  height: 48.0,
                  width: 32.0,
                ),
                foodItemServings: (foodItemServingsState) {
                  if (foodItemServingsState.selectedServing == null) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FavouriteBtn(
                      isActive: foodItemServingsState.selectedServing?.isSelectedFavorite ?? false,
                      onPress: _onFavouritePressed,
                    ),
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(_kBottomPreferredHeight),
          child: Container(
            width: double.infinity,
            height: _kBottomPreferredHeight,
            color: AppColors.greenLighter,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: CustomText.bitter600(
              widget.foodItemName,
              maxLines: 2,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: ServingList(),
          ),
          BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
            builder: (context, state) {
              final servingAmount = double.parse(state.selectedServingAmount ?? '0');
              final servingId = state.selectedServingItem?.servingId;
              final enable = double.parse(state.selectedServingAmount ?? '0') != 0;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: enable ? () => _onConfirmPressed(context, servingAmount, servingId) : null,
                  label: LocalizedTexts.confirm,
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  _onConfirmPressed(BuildContext context, double amount, String? id) {
    if (id != null) {
      widget.onConfirm.call(amount, id);
    }
    context.router.pop();
  }

  String _getSnackBarText(bool isFavorite, bool hasActiveFilters) {
    return isFavorite && !hasActiveFilters
        ? LocalizedTexts.removedFromFavorites.tr()
        : LocalizedTexts.addedToFavorites.tr();
  }

  _showSnackBar() {
    final state = context.read<FoodItemServingsBloc>().state;

    final isFavorite = state.selectedServingItem?.isSelectedFavorite ?? false;

    final snackBarText = _getSnackBarText(isFavorite, state.hasSelectedMealCategoryFilters);

    context.showSuccessBar(content: Text(snackBarText));
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
        ? LocalizedTexts.removeFromFavorites.tr()
        : LocalizedTexts.addAsFavourite.tr();

    final subTitle = widget.foodItemName;
    final serving = state.selectedServingItem?.servingLabel;

    context.read<FoodItemServingsBloc>().add(FoodItemServingsEvent.setMealCategoryFilters(
          state.filtersForSelectedServing,
        ));

    ModalBottomSheet.filterDialogFavorites(
      context: context,
      title: title,
      subtitle: subTitle,
      serving: serving,
      onConfirmed: _onAddAsFavouriteConfirmedPressed,
      listWidget: MealCategoryFiltersList(
        onFilterPressed: _onFavouriteFilterPressed,
      ),
    );
  }
}
