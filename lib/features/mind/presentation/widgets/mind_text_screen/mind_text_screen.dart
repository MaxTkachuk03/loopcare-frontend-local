import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_linc_content_render.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class MindTextScreen extends StatelessWidget {
  const MindTextScreen({
    super.key,
    required this.title,
    required this.url,
    required this.buttonLabel,
    required this.onCompleted,
    required this.leading,
    required this.backgroundBrightness,
  });

  final String title;
  final String url;
  final String buttonLabel;
  final Widget? leading;
  final Brightness backgroundBrightness;
  final void Function()? onCompleted;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = backgroundBrightness == Brightness.dark
        ? AppColors.petrolOffRegular
        : AppColors.petrolLightest;

    final textColor = backgroundBrightness == Brightness.dark
        ? AppColors.white
        : AppColors.blueDarker;

    return CustomScaffold(
      withBg: false,
      color: backgroundColor,
      appBar: CustomAppBar.petrol(
        title: title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  if (leading != null) ...[
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: leading!,
                    ),
                  ],
                  const SizedBox(height: 20.0),
                  HtmlLaunchContentRender(
                    url: url,
                    textStyle: TextStyle(height: 1.5, color: textColor),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
              MainContainer(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: CustomElevatedButton.yellowFullWidth(
                    onPressed: onCompleted,
                    label: buttonLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
