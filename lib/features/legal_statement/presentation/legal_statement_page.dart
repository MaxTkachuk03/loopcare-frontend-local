import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/widgets/legal_statement_confirmation_box.dart';

class LegalStatementPage extends StatefulWidget {
  const LegalStatementPage({super.key});

  @override
  State<LegalStatementPage> createState() => _LegalStatementPageState();
}

class _LegalStatementPageState extends State<LegalStatementPage> {
  final valueListener = ValueNotifier<bool>(false);

  @override
  void dispose() {
    valueListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: CustomScaffold.blueLightest(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.legalStatement.tr(),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 32.0),
                      CustomText.bitter600(
                        LocalizedTexts.legalStatement.tr(),
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 32.0),
                      CustomText.w400(
                        '${LocalizedTexts.legalStatementTextOne.tr()}.',
                        style: context.textTheme.bodyMedium,
                      ),
                      // TODO removed during LOOPCARE-2000 task 25.01.2024
                      // const SizedBox(height: 16.0),
                      // CustomText.w400(
                      //   '${LocalizedTexts.legalStatementTextTwo.tr()}.',
                      //   style: context.textTheme.bodyMedium,
                      // ),
                      // const SizedBox(height: 38.0),
                      // CustomElevatedButton.coralSmall(
                      //   onPressed: () => _onReadLegalStatement(context),
                      //   label: LocalizedTexts.readLegalStatement,
                      // ),
                      const SizedBox(height: 27.0),
                      LegalStatementConfirmationBox(
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: valueListener,
                    builder: (context, value, _) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 42.0),
                        child: CustomElevatedButton.blueFullWidth(
                          onPressed: value ? onConfirm : null,
                          label: LocalizedTexts.confirm.tr(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onChanged(bool value) => valueListener.value = value;

  void onConfirm() {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.legalStatement,
      parameters: {
        CustomDefinitions.value: 'true',
      },
    );

    context
      ..read<LegalStatementBloc>().add(const LegalStatementEvent.passageChanged(true))
      ..router.replaceAll([const SignUpWelcomeRoute()]);
  }

  Future<bool> onWillPop() async {
    context.read<ConsentConfirmationBloc>().add(const ConsentConfirmationEvent.passageChanged(false));

    return Future.value(true);
  }
}
