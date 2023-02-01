import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/widgets/email_address_form.dart';

class EmailAddressPage extends StatefulWidget {
  const EmailAddressPage({Key? key}) : super(key: key);

  @override
  State<EmailAddressPage> createState() => _EmailAddressPageState();
}

class _EmailAddressPageState extends State<EmailAddressPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizedTexts.createAccount.tr()),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    LocalizedTexts.whatIsYourEmailAddress.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    LocalizedTexts.emailPageDescription.tr(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  const EmailAddressForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
