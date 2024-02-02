import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class SignUpWelcomePage extends StatelessWidget {
  const SignUpWelcomePage({super.key});

  void _onNextPressed(BuildContext context) {
    context
      ..read<AuthenticationCubit>().changeToNameState()
      ..router.pushNamed(AppRoutes.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.green(
      appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingGreenLighter()),
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
                    Container(alignment: Alignment.center, child: const Image(image: AppImages.welcome)),
                    const SizedBox(height: 30.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.signUpWelcomeTitle.tr()}!',
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: CustomText.w400(
                        '${LocalizedTexts.signUpWelcomeBody.tr()}.',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 20.0),
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.letsGo,
                      onPressed: () => _onNextPressed(context),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
