import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/widgets/legal_statement_confirmation_box.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class LegalStatementPage extends StatefulWidget {
  const LegalStatementPage({super.key});

  @override
  State<LegalStatementPage> createState() => _LegalStatementPageState();
}

class _LegalStatementPageState extends State<LegalStatementPage> {
  final valueListener = ValueNotifier<bool>(false);
  final usageAnalytics = UsageAnalytics();

  @override
  void initState() {
    super.initState();
    usageAnalytics.track(
        eventName: UsageAnalyticsEvents.onboardingLegalStatement);
  }

  @override
  void dispose() {
    super.dispose();
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
    context
      ..read<LegalStatementBloc>()
          .add(const LegalStatementEvent.passageChanged(true))
      ..router.pushNamed(AppRoutes.signUpWelcome);
  }
}
