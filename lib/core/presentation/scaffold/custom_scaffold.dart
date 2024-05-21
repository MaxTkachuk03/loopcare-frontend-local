import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/widgets/bottom_bg.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomScaffold extends StatelessWidget {
  final CustomAppBar? appBar;
  final Widget? body;
  final Color color;
  final bool? resizeToAvoidBottomInset;
  final bool withBg;
  final Widget? bottomSheet;

  const CustomScaffold({
    super.key,
    required this.appBar,
    required this.withBg,
    required this.color,
    this.body,
    this.resizeToAvoidBottomInset,
    this.bottomSheet,
  });

  factory CustomScaffold.coralLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.coralLightest,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.coral({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.coralOffRegular,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.orangeLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.orangeLightest,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.orange({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    Widget? bottomSheet,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.orangeOffRegular,
        bottomSheet: bottomSheet,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.yellowLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? resizeToAvoidBottomInset,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.yellowLightest,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.yellow({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.yellowOffRegular,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.greenLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.greenLightest,
        withBg: withBg ?? false,
      );
  factory CustomScaffold.greenLighter({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.greenLighter,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.green({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.greenOffRegular,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.greenDarker({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.greenDarker,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.petrolLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.petrolLightest,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.petrol({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.petrolOffRegular,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.blueLightest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.blueLightest,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.blue({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? needBottomFacture,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.blueOffRegular,
        withBg: withBg ?? false,
      );

  factory CustomScaffold.blueDarkest({
    Key? key,
    CustomAppBar? appBar,
    Widget? body,
    bool? withBg,
  }) =>
      CustomScaffold(
        key: key,
        appBar: appBar,
        body: body,
        color: AppColors.blueDarkest,
        withBg: withBg ?? false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      bottomSheet: bottomSheet,
      body: Stack(
        children: [
          if (withBg) BottomBg(color: color),
          if (body != null) body!,
        ],
      ),
    );
  }
}
