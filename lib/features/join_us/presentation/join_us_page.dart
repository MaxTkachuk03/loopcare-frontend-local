import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

@Deprecated('Not include in River Onboarding')
@RoutePage()
class JoinUsPage extends StatelessWidget {
  const JoinUsPage({super.key});

  void _onStartPressed(BuildContext context) => context.router.pushNamed(AppRoutes.name);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      key: const ValueKey('join_us_page'),
      appBar: CustomAppBar.transparent(
        leading: CustomFilledIconButton.leadingWhite(),
      ),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: MainContainer(
            child: ListView(
              key: const ValueKey('join_us_body'),
              physics: const ClampingScrollPhysics(),
              children: [
                const Center(
                  child: Image(image: AppImages.intro2),
                ),
                const SizedBox(height: 28.0),
                CustomText.bitter600(
                  '${LocalizedTexts.intro2Title.tr()}!',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: CustomText.w600(
                    '${LocalizedTexts.intro2BodyTextFirst.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: CustomText.w400(
                    '${LocalizedTexts.intro2BodyTextSecond.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            key: const ValueKey('join_us_start_button'),
            label: LocalizedTexts.start.tr(),
            onPressed: () => _onStartPressed(context),
          ),
        ),
      ),
    );
  }
}
