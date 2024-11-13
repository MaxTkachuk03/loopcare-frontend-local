import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

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
    final mealCategory = context.read<MealsBloc>().state.data.currentMealCategory;
    context.router.push(SelectFoodRoute(mealCategory: mealCategory));
  }
}
