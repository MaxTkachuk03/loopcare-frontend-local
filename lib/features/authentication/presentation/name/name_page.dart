import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class NamePage extends StatelessWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  LocalizedTexts.whatIsYourName.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontFamily: ThemeConstants.bitterFontFamily,
                      ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  LocalizedTexts.namePageDescription.tr(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Field(
                  hintText: LocalizedTexts.yourName.tr(),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _onNextPressed,
                  child: Text(LocalizedTexts.next.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPressed() {}
}
