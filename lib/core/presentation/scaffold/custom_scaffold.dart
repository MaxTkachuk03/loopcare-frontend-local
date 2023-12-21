import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomScaffold extends StatelessWidget {
  final CustomAppBar? appBar;
  final Widget? body;
  final Color? color;

  const CustomScaffold({super.key, required this.appBar, this.body, this.color});

  factory CustomScaffold.coralLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralLightest);

  factory CustomScaffold.coral({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralOffRegular);

  factory CustomScaffold.orangeLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeLightest);

  factory CustomScaffold.orange({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeOffRegular);

  factory CustomScaffold.yellowLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.yellowLightest);

  factory CustomScaffold.yellow({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.yellowOffRegular);

  factory CustomScaffold.greenLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.greenLightest);

  factory CustomScaffold.green({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.greenOffRegular);

  factory CustomScaffold.greenDarker({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.greenDarker);

  factory CustomScaffold.petrolLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.petrolLightest);

  factory CustomScaffold.petrol({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.petrolOffRegular);

  factory CustomScaffold.blueLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueLightest);

  factory CustomScaffold.blue({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueOffRegular);

  factory CustomScaffold.blueDarkest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueDarkest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: appBar,
      body: body,
    );
  }
}
