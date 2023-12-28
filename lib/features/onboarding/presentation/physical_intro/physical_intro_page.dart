import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class PhysicalIntroPage extends StatelessWidget {
  const PhysicalIntroPage({super.key});

  void _onNextPressedHandler(BuildContext context) => context.router.pushNamed(AppRoutes.birthday);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.yellow(
      appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingYellowLighter()),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Container(
                        alignment: Alignment.center, child: const Image(image: AppImages.physicalIntro)),
                  ],
                ),
                Column(
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.physicalIntroTitle.tr(),
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.watch_later_outlined),
                        const SizedBox(width: 10),
                        CustomText.w600(
                          '5 ${LocalizedTexts.minutes.tr()}',
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustomText.w400(
                      '${LocalizedTexts.physicalIntroBody.tr()}.',
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.next,
                      onPressed: () => _onNextPressedHandler(context),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
