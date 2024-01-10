import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/instructions_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/widgets/legal_statement_confirmation_box.dart';

class LegalStatementPage extends StatelessWidget {
  const LegalStatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold.blueLightest(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.legalStatement.tr(),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32.0),
                  CustomText.bitter600(
                    LocalizedTexts.legalStatement.tr(),
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 32.0),
                  CustomText.w400(
                    LocalizedTexts.legalStatementTextOne.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  CustomText.w400(
                    LocalizedTexts.legalStatementTextTwo.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 38.0),
                  CustomElevatedButton.coralSmall(
                    onPressed: () => _onReadLegalStatement(context),
                    label: LocalizedTexts.readLegalStatement,
                  ),
                  const SizedBox(height: 27.0),
                  const LegalStatementConfirmationBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onReadLegalStatement(BuildContext context) async {
    InstructionsService.downloadInstructions(onErrorCb: _showError(context));
  }

  _showError(BuildContext context) =>
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.translation));

  Future<bool> _onWillPop(BuildContext context) async {
    context.read<ConsentConfirmationBloc>().add(const ConsentConfirmationEvent.passageChanged(false));

    return Future.value(true);
  }
}
