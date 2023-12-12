import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomScaffold extends StatelessWidget {
  final CustomAppBar appBar;
  final Widget? body;
  final Color? color;

  const CustomScaffold({super.key, required this.appBar, this.body, this.color});

  factory CustomScaffold.coralLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralLightest);

  factory CustomScaffold.coral({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralOffRegular);

  factory CustomScaffold.orangeLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeLightest);

  factory CustomScaffold.orange({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeOffRegular);

  factory CustomScaffold.yellowLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.yellowLightest);

  factory CustomScaffold.yellow({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.yellowOffRegular);

  factory CustomScaffold.greenLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.greenLightest);

  factory CustomScaffold.green({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.greenOffRegular);

  factory CustomScaffold.petrolLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.petrolLightest);

  factory CustomScaffold.petrol({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.petrolOffRegular);

  factory CustomScaffold.blueLightest({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueLightest);

  factory CustomScaffold.blue({required CustomAppBar appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueOffRegular);

  factory CustomScaffold.blueDarkest({required CustomAppBar appBar, Widget? body}) =>
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
