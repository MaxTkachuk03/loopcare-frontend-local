// import 'package:flutter/material.dart';
// import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
// import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/features/reflection/presentation/widgets/details_button.dart';

// class WeightSection extends StatelessWidget {
//   const WeightSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24.0),
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.0),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Weight',
//             style: TextStyle(
//               fontSize: ThemeConstants.fontSize24,
//               fontFamily: ThemeConstants.bitterFontFamily,
//             ),
//           ),
//           const SizedBox(
//             height: 16.0,
//           ),
//           const Image(
//             width: double.infinity,
//             image: AppImages.reflectionWeight,
//           ),
//           const SizedBox(
//             height: 16.0,
//           ),
//           Text(
//             'Last measured weight on May 30th',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           const SizedBox(
//             height: 8.0,
//           ),
//           RichText(
//             text: TextSpan(
//               style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                     fontFamily: ThemeConstants.bitterFontFamily,
//                   ),
//               children: [
//                 TextSpan(
//                   text: '203 ',
//                   style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                         color: AppColors.blueMid,
//                       ),
//                 ),
//                 TextSpan(
//                   text: 'lbs',
//                   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                         fontWeight: FontWeight.w400,
//                         fontFamily: ThemeConstants.bitterFontFamily,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 8.0,
//           ),
//           const Row(
//             children: [
//               SizedBox(
//                 width: 14,
//                 child: ImageIcon(
//                   AppIcons.arrowDown,
//                   color: AppColors.greenRegular,
//                 ),
//               ),
//               SizedBox(width: 6.0),
//               Text('4 lbs lower than last month'),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           const Divider(
//             color: AppColors.yellowLight,
//             thickness: 1,
//             height: 1,
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             'You are on the right track!',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(
//             height: 8.0,
//           ),
//           Text(
//             'You may think 4 lbs lost is not a big deal but it’s a great monthly average. This is how you create sustainable weight loss - remember slow and steady wins the race.',
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           const DetailsButton()
//         ],
//       ),
//     );
//   }
// }
