import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

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
                                .headline3
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
                            onPressed: _onNextPressed,
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

  void _onNextPressed() {}
}
