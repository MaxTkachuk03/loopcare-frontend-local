import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/widgets/legal_statement_confirmation_box.dart';

@RoutePage()
class LegalStatementPage extends StatefulWidget {
  const LegalStatementPage({super.key});

  @override
  State<LegalStatementPage> createState() => _LegalStatementPageState();
}

class _LegalStatementPageState extends State<LegalStatementPage> {
  final valueListener = ValueNotifier<bool>(false);
  late ConsentConfirmationBloc _consentBloc;

  @override
  void initState() {
    super.initState();
    _consentBloc = context.read<ConsentConfirmationBloc>();
    CustomerIoService.track(event: CIOEvents.onboardingLegalStatement);
  }

  @override
  void dispose() {
    super.dispose();

    _consentBloc.add(const ConsentConfirmationEvent.passageChanged(false));
    valueListener.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.legalStatement.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: MainContainer(
            child: ListView(
              physics: const ClampingScrollPhysics(),
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
          ),
          button: ValueListenableBuilder<bool>(
            valueListenable: valueListener,
            builder: (context, value, _) {
              return CustomElevatedButton.blueFullWidth(
                onPressed: value ? onConfirm : null,
                label: LocalizedTexts.confirm.tr(),
              );
            },
          ),
        ),
      ),
    );
  }

  void onChanged(bool value) => valueListener.value = value;

  void onConfirm() {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.legalStatement,
      parameters: {
        AnalyticsParameters.value: 'true',
      },
    );

    CustomerIoService.track(event: CIOEvents.onboardingRegisterIntro);

    context
      ..read<LegalStatementBloc>().add(const LegalStatementEvent.passageChanged(true))
      ..router.pushNamed(AppRoutes.signUpWelcome);
  }
}
