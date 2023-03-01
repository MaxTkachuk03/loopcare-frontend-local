import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class SignUpWelcomePage extends StatelessWidget {
  const SignUpWelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Image(image: AppImages.signUpWelcome),
                      Positioned(
                        bottom: -53,
                        child: Align(
                          child: AppImages.logoSvgGreenBig,
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    top: false,
                    child: MainContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocalizedTexts.signUpWelcomeTitle.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                  fontSize: 30.0,
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            LocalizedTexts.signYouUp.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            LocalizedTexts.needName.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 80.0,
                          ),
                          ElevatedButton(
                            onPressed: () => _onNextPressed(context),
                            child: Text(LocalizedTexts.next.tr()),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onNextPressed(BuildContext context) {
    context
      ..read<AuthenticationCubit>().changeToNameState()
      ..router.pushNamed(AppRoutes.name);
  }
}
