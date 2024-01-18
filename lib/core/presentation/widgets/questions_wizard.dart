
// TODO: Dead Code
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

// class QuestionsWizard extends StatelessWidget {
//   final Widget question;
//   final Widget questionList;
//   final String currentStep;
//   final String stepTitle;
//   final void Function() onNextPressed;

//   const QuestionsWizard({
//     super.key,
//     required this.question,
//     required this.questionList,
//     required this.currentStep,
//     required this.stepTitle,
//     required this.onNextPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text(stepTitle),
//             Text(
//               currentStep,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: MainContainer(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 48.0,
//               ),
//               question,
//               const SizedBox(
//                 height: 26.0,
//               ),
//               Expanded(
//                 child: ScrollableContainer(
//                   child: questionList,
//                 ),
//               ),
//               Column(
//                 children: [
//                   const SizedBox(
//                     height: 22.0,
//                   ),
//                   ElevatedButton(
//                     onPressed: onNextPressed,
//                     style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
//                       backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.disabled)) {
//                             return AppColors.greyMid;
//                           }
//                           return AppColors.orangeDark;
//                         },
//                       ),
//                     ),
//                     child: Text(
//                       LocalizedTexts.next.tr(),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16.0,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
