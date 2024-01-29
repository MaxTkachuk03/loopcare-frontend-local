import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomScaffold extends StatelessWidget {
  final CustomAppBar? appBar;
  final Widget? body;
  final Color? color;
  final bool? resizeToAvoidBottomInset;
  final bool? needBottomFacture;
  final Widget? bottomSheet;

  const CustomScaffold({
    super.key,
    required this.appBar,
    this.body,
    this.color,
    this.resizeToAvoidBottomInset,
    this.needBottomFacture,
    this.bottomSheet,
  });

  factory CustomScaffold.coralLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralLightest);

  factory CustomScaffold.coral({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.coralOffRegular);

  factory CustomScaffold.orangeLightest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeLightest);

  factory CustomScaffold.orange({CustomAppBar? appBar, Widget? body, Widget? bottomSheet}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.orangeOffRegular, bottomSheet: bottomSheet);

  factory CustomScaffold.yellowLightest(
          {CustomAppBar? appBar, Widget? body, bool? resizeToAvoidBottomInset}) =>
      CustomScaffold(
        appBar: appBar,
        body: body,
        color: AppColors.yellowLightest,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );

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

  factory CustomScaffold.blue({CustomAppBar? appBar, Widget? body, bool? needBottomFacture}) =>
      CustomScaffold(
          appBar: appBar, body: body, color: AppColors.blueOffRegular, needBottomFacture: needBottomFacture);

  factory CustomScaffold.blueDarkest({CustomAppBar? appBar, Widget? body}) =>
      CustomScaffold(appBar: appBar, body: body, color: AppColors.blueDarkest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      bottomSheet: bottomSheet,
      body: Stack(
        children: [
          if (needBottomFacture ?? false)
            Positioned(
              bottom: 0,
              child: AppImages.bottomFrame,
            ),
          if (body != null) body!,
        ],
      ),
    );
  }
}
