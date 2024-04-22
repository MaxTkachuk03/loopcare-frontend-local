import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class MindTextScreen extends StatelessWidget {
  const MindTextScreen({
    super.key,
    required this.title,
    required this.content,
    required this.buttonLabel,
    required this.onCompleted,
    required this.leading,
  });

  final String title;
  final String content;
  final String buttonLabel;
  final Widget? leading;
  final void Function()? onCompleted;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      withBg: false,
      color: AppColors.petrolOffRegular,
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
                  HtmlRenderer(
                    content: content,
                    textStyle: const TextStyle(height: 1.5, color: AppColors.white),
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
