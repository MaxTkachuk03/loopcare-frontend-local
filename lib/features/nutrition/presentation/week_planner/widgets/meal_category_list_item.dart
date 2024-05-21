// import 'package:auto_route/auto_route.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
// import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';
//
// class MealCategoryListItem extends StatelessWidget {
//   final String mealCategory;
//   final List<MealItem> mealItems;
//   final DateTime date;
//
//   const MealCategoryListItem({
//     super.key,
//     required this.mealItems,
//     required this.mealCategory,
//     required this.date,
//   });
//
//   void editPlannedMeal(BuildContext context) {
//     final mealsBloc = context.read<MealsBloc>();
//     final plannedMeals = mealsBloc.state.mapOrNull(mealsInfo: (s) => s.data.plannedMeals);
//     final plannedMealForCurrentDate = plannedMeals?[date.isoStringWithoutTime]
//         ?.firstWhereOrNull((element) => element.mealCategory == mealCategory);
//
//     context.router.pushNamed(AppRoutes.meal);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return mealItems.isEmpty
//         ? const SizedBox.shrink()
//         : Container(
//             padding: const EdgeInsets.only(top: 8.0),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: GestureDetector(
//               onTap: () => editPlannedMeal(context),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     flex: 9,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           mealCategory.toUpperCase(),
//                           style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
//                         ),
//                         const SizedBox(height: 16.0),
//                         GroupedMealList(
//                           mealItems: mealItems,
//                           active: true,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Expanded(
//                     flex: 1,
//                     child: ImageIcon(
//                       AppIcons.arrow,
//                       color: AppColors.anotherBlue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
