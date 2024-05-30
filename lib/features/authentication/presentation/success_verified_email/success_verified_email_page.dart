import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

@Deprecated('Not include in River Onboarding')
class SuccessVerifiedEmailPage extends StatelessWidget {
  const SuccessVerifiedEmailPage({super.key});

  void _onStartPressed(BuildContext context) => context.router.pushNamed(AppRoutes.onboardingIntro);

  @override
  Widget build(BuildContext context) {
    final userName = context.read<AuthenticationBloc>().state.data.nameCapitalised;

    return CustomScaffold.blueLightest(
      key: const ValueKey('success_verified_email_page'),
      appBar: CustomAppBar.transparent(
        leading: CustomFilledIconButton.leadingWhite(),
      ),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: MainContainer(
            child: ListView(
              key: const ValueKey('success_verified_email_body'),
              physics: const ClampingScrollPhysics(),
              children: [
                Container(alignment: Alignment.center, child: const Image(image: AppImages.intro2)),
                const SizedBox(height: 28.0),
                CustomText.bitter700(
                  '${LocalizedTexts.intro3Title.tr()}, $userName!',
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: CustomText.w600(
                    '${LocalizedTexts.intro3BodyTextFirst.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: CustomText.w400(
                    '${LocalizedTexts.intro3BodyTextSecond.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            key: const ValueKey('success_verified_email_start_button'),
            label: LocalizedTexts.start.tr(),
            onPressed: () => _onStartPressed(context),
          ),
        ),
      ),
    );
  }
}
