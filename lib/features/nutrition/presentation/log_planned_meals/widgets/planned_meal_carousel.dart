// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/widgets/planned_meal_card.dart';
//
// class PlannedMealCarousel extends StatefulWidget {
//   final NameLabel selectedMealCategory;
//
//   const PlannedMealCarousel({
//     super.key,
//     required this.selectedMealCategory,
//   });
//
//   @override
//   State<PlannedMealCarousel> createState() => _PlannedMealCarouselState();
// }
//
// class _PlannedMealCarouselState extends State<PlannedMealCarousel> {
//   late PageController _pageController;
//   int currentPage = 0;
//
//   @override
//   void initState() {
//     final plannedMealsForCurrentDate = context.read<MealsBloc>().state.plannedMealsForCurrentDate;
//     final indexCurrentCategory =
//         plannedMealsForCurrentDate.indexWhere((element) => element.mealCategory == widget.selectedMealCategory.label);
//     final initialPage = indexCurrentCategory > 0 ? indexCurrentCategory : 0;
//     setState(() {
//       currentPage = initialPage;
//     });
//     _pageController = PageController(initialPage: currentPage, viewportFraction: .85);
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MealsBloc, MealsState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: state.plannedMealsForCurrentDate.length,
//                 onPageChanged: _onPageChanged,
//                 itemBuilder: (BuildContext context, index) {
//                   final groupedMealItem =
//                       groupBy(state.plannedMealsForCurrentDate[index].mealItems, (MealItem mealItem) => mealItem.type);
//
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: PlannedMealCard(
//                       plannedMealId: state.plannedMealsForCurrentDate[index].id,
//                       mealItem: groupedMealItem,
//                       mealCategory: state.plannedMealsForCurrentDate[index].mealCategory,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: state.plannedMealsForCurrentDate
//                   .mapIndexed(
//                     (index, el) => Hexagon(
//                       width: 16,
//                       height: 16,
//                       borderRadius: 4.0,
//                       innerWidget: Container(
//                         color: currentPage == index ? AppColors.blueMid : AppColors.yellowLight,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   _onPageChanged(int index) {
//     setState(() {
//       currentPage = index;
//     });
//   }
// }
