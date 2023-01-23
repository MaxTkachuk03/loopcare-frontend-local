import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

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
                          child: AppImages.logoSvgMedium,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          LocalizedTexts.forgotYourPasswordTitle.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                  color: AppColors.blueDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          LocalizedTexts.forgotYourPasswordText.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 36.0),
                        Field(
                          hintText: LocalizedTexts.yourEmail.tr(),
                          prefixIcon: AppIcons.iconMail,
                        ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: _onContinuePressed,
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.blueDark),
                              ),
                          child: Text(LocalizedTexts.continueBtn.tr()),
                        ),
                        const SizedBox(height: 23.0),
                        Text(
                          LocalizedTexts.returnToLoginScreen.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
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

  void _onContinuePressed() {}
}
