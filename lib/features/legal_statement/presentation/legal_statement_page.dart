import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/widgets/legal_statement_confirmation_box.dart';

import 'package:url_launcher/url_launcher.dart';

class LegalStatementPage extends StatelessWidget {
  const LegalStatementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizedTexts.legalStatement.tr(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                          color: AppColors.blueDark,
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    LocalizedTexts.legalStatementTextOne.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    LocalizedTexts.legalStatementTextTwo.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: _onReadLegalStatement,
                    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          minimumSize: MaterialStateProperty.all(
                            const Size(
                              0,
                              38,
                            ),
                          ),
                          textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
                        ),
                    child: Text(LocalizedTexts.readLegalStatement.tr()),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const LegalStatementConfirmationBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onReadLegalStatement() async {
    await launchUrl(
      Uri.parse('https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf'),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    context.read<ConsentConfirmationBloc>().add(const ConsentConfirmationEvent.passageChanged(false));

    return Future.value(true);
  }
}
