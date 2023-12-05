import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40.0),
                        Align(
                          alignment: Alignment.center,
                          child: AppImages.logoSvgBig,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          LocalizedTexts.welcomeTitle.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontFamily: ThemeConstants.bitterFontFamily, color: AppColors.blueDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          LocalizedTexts.dontHaveAccount.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 36.0),
                        const LoginForm(),
                        const SizedBox(height: 23.0),
                        InkWell(
                          onTap: () => _onForgotMyPassword(context),
                          child: Text(
                            LocalizedTexts.forgotMyPassword.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 23.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onForgotMyPassword(BuildContext context) {
    context.router.pushNamed(AppRoutes.forgotPassword);
  }
}
