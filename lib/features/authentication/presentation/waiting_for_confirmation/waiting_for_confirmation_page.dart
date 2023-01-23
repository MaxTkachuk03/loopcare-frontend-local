import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class WaitingForConfirmationPage extends StatelessWidget {
  const WaitingForConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 100.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      LocalizedTexts.waitingForConfirmationTitle.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                          ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 45.0,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        LocalizedTexts.confirmYourAddress.tr(),
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: AppColors.blueDark,
                              fontSize: 20.0,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        LocalizedTexts.checkSpam.tr(),
                        style:
                            Theme.of(context).textTheme.bodyText2?.copyWith(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        '${LocalizedTexts.address.tr()}: email address',
                        style:
                            Theme.of(context).textTheme.bodyText2?.copyWith(),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: _onResendPressed,
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.bgGreen),
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.darkGreen),
                          ),
                      child: Text(
                        LocalizedTexts.resend.tr(),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: _onChangeAddressPressed,
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.bgGreen),
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.darkGreen),
                          ),
                      child: Text(
                        LocalizedTexts.changeAddress.tr(),
                      ),
                    ),
                    const SizedBox(height: 80.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResendPressed() {}

  void _onChangeAddressPressed() {}
}
