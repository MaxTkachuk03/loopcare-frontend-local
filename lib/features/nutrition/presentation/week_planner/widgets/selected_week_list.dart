// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:collection/collection.dart';
// import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
// import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
// import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
// import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
// import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
// import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/empty_day_card.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/filled_day_card.dart';
// import 'package:loopcare_frontend/features/video_session/presentation/widgets/info_dialog.dart';
//
// class SelectedWeekList extends StatelessWidget {
//   final List<MealsListItem> mealsListItems;
//   final DateTime date;
//   final bool active;
//
//   const SelectedWeekList({
//     super.key,
//     required this.mealsListItems,
//     required this.date,
//     this.active = false,
//   });
//
//   void _onPressHandler(BuildContext context) {
//     ModalBottomSheet.selectAMealDialog(
//       context: context,
//       filledList: context.read<MealsBloc>().state.filledPlannedMealCategories,
//       currentDate: context.read<MealsBloc>().state.getCurrentDate,
//       list: MealCategory.values
//           .map(
//             (e) => NameLabel(
//               name: e.name,
//               label: e.label ?? '',
//               shortValue: e.shortValue,
//               icon: e.icon,
//             ),
//           )
//           .toList(),
//       onSelect: (NameLabel item) {
//         final mealsBloc = context.read<MealsBloc>();
//         final plannedMeals = mealsBloc.state.mapOrNull(mealsInfo: (s) => s.plannedMeals);
//         final plannedMealsForCurrentDate = plannedMeals?[mealsBloc.state.getCurrentDate.isoStringWithoutTime]
//             ?.firstWhereOrNull((element) => element.mealCategory == item.label);
//
//         if (plannedMealsForCurrentDate != null) {
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => InformationDialog(
//               content: LocalizedTexts.existMealText.tr(),
//               okText: LocalizedTexts.createNew.tr().toUpperCase(),
//               cancelText: LocalizedTexts.updateExist.tr().toUpperCase(),
//               onOkHandler: () {
//                 createPlannedMeal(context, item, mealsBloc.state.getCurrentDate);
//               },
//               onCancelHandler: () {
//                 editPlannedMeal(context, plannedMealsForCurrentDate);
//               },
//             ),
//           );
//         } else {
//           createPlannedMeal(context, item, mealsBloc.state.getCurrentDate);
//         }
//       },
//     );
//   }
//
//   void editPlannedMeal(BuildContext context, MealsListItem plannedMealsForCurrentDate) {
//     context.router.pop();
//     context.read<MealsBloc>().add(MealsEvent.setPlannedMeal(plannedMealsForCurrentDate));
//
//     context.router.pushNamed(AppRoutes.meal);
//   }
//
//   void createPlannedMeal(BuildContext context, NameLabel item, DateTime day) {
//     context.router.pop();
//
//     context.read<RecipeBloc>().add(RecipeEvent.getRecommendations(item.name.toLowerCase()));
//     context.read<MealsBloc>().add(MealsEvent.addPlannedMeal(item.name.toLowerCase()));
//
//     context.router.push(
//       RecommendationsRoute(
//         mealCategory: item.name.toLowerCase(),
//         date: day,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return mealsListItems.isEmpty
//         ? EmptyDayCard(
//             date: date,
//             onPressHandler: () => _onPressHandler(context),
//           )
//         : FilledDayCard(
//             date: date,
//             mealItems: mealsListItems,
//             onPressHandler: () => _onPressHandler(context),
//           );
//   }
// }
