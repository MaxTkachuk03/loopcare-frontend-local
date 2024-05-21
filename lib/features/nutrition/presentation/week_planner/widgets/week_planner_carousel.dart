// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
// import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
// import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/selected_week_list.dart';
//
// class WeekPlannerCarousel extends StatefulWidget {
//   const WeekPlannerCarousel({
//     super.key,
//   });
//
//   @override
//   State createState() => _WeekPlannerCarouselState();
// }
//
// class _WeekPlannerCarouselState extends State<WeekPlannerCarousel> {
//   late PageController _pageController;
//   int currentPage = 0;
//
//   @override
//   void initState() {
//     initPage();
//
//     super.initState();
//   }
//
//   void initPage() {
//     final selectedDate = context.read<ChooseDateBloc>().state.data.currentDate ?? DateTime.now().midnightTime;
//
//     final initialPage = selectedDate.isToday ? selectedDate.weekday : selectedDate.weekday - 1;
//
//     _pageController = PageController(
//       keepPage: false,
//       initialPage: currentPage,
//       viewportFraction: .85,
//     );
//
//     setState(() {
//       currentPage = initialPage;
//       jumpToPage();
//     });
//   }
//
//   void _dateChange(BuildContext context, _) {
//     initPage();
//     jumpToPage();
//   }
//
//   void jumpToPage() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_pageController.hasClients) {
//         _pageController.jumpToPage(currentPage);
//       }
//     });
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
//     return BlocConsumer<ChooseDateBloc, ChooseDateState>(
//       listenWhen: (prev, cur) => prev.data.currentDate != cur.data.currentDate,
//       listener: _dateChange,
//       builder: (context, state) {
//         var plannedMeals = state.data.plannedMealsForSelectedWeek;
//         return Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: plannedMeals.length,
//                 onPageChanged: _onPageChanged,
//                 itemBuilder: (BuildContext context, index) {
//                   final key = plannedMeals.keys.elementAt(index);
//                   final value = plannedMeals[key];
//
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: SelectedWeekList(
//                       mealsListItems: value ?? [],
//                       date: DateTime.parse(key),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: plannedMeals.entries
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
//
//     var chooseDateBloc = context.read<ChooseDateBloc>();
//
//     var plannedMeals = chooseDateBloc.state.data.plannedMealsForSelectedWeek;
//     final key = plannedMeals.keys.elementAt(index);
//     var day = (DateTime.parse(key));
//
//     context.read<MealsBloc>().add(MealsEvent.setCurrentDate(day));
//   }
// }
