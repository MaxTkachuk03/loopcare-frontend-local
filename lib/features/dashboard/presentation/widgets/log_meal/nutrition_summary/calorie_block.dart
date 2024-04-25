// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
// import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
// import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
// import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
// import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

// class CalorieBlock extends StatelessWidget {
//   final double? value;
//   final void Function({required int tabIndex}) onPress;

//   const CalorieBlock({
//     super.key,
//     this.value,
//     required this.onPress,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
//       builder: (BuildContext context, state) {
//         return state.maybeMap(
//             loaded: (state) {
//               final currentCalorieDensityItem = state.data.getCalorieDensityItem(value);

//               if (state.data.calorieDensityValues.isEmpty) return const SizedBox();

//               final label = currentCalorieDensityItem != null
//                   ? currentCalorieDensityItem.label.capitalizeOnlyFirstLetter()
//                   : '-';

//               return GestureDetector(
//                 onTap: _onItemPressed,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           LocalizedTexts.calorieDensity.tr().toUpperCase(),
//                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                 fontSize: ThemeConstants.fontSize12,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.greyLabel,
//                               ),
//                         ),
//                         const SizedBox(width: 4.0),
//                         const ImageIcon(
//                           AppIcons.arrow,
//                           color: AppColors.blueDarker,
//                           size: 10,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5.0),
//                     Text(
//                       label,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             fontSize: 14.0,
//                           ),
//                     ),
//                     const SizedBox(height: 5.0),
//                     SizedBox(
//                       height: 22.0,
//                       child: CalorieDensityScale(
//                         density: value,
//                         layout: CalorieDensityScaleLayout.horizontal,
//                         separatorColor: AppColors.bgGreen,
//                         separatorSize: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             orElse: () => const SizedBox.shrink());
//       },
//     );
//   }

//   _onItemPressed() {
//     onPress(tabIndex: 0);
//   }
// }
