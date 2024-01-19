// TODO dead code

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
// import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
// import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
// import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
// import 'package:loopcare_frontend/features/onboarding/presentation/simple_progress_bar.dart';
//
// class QuestionWrap extends StatelessWidget {
//   final Widget child;
//   final bool? isWithOnWillPop;
//   final Future<bool> Function() onPreviousPage;
//
//   const QuestionWrap({
//     super.key,
//     required this.child,
//     required this.onPreviousPage,
//     this.isWithOnWillPop,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isWithOnWillPop = this.isWithOnWillPop;
//
//     return WillPopScope(
//       onWillPop: isWithOnWillPop != null && !isWithOnWillPop ? null : onPreviousPage,
//       child: CustomScaffold(
//         appBar: CustomAppBar.yellow(
//           title: LocalizedTexts.physicalIntroTitle.tr(),
//           leading: CustomFilledIconButton.leadingYellowLighter(),
//         ),
//         body: SafeArea(
//           bottom: false,
//           child: ScrollableContainer(
//             child: MainContainer(
//               child: Column(
//                 children: [
//                   const ProgressBar(),
//                   child,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
