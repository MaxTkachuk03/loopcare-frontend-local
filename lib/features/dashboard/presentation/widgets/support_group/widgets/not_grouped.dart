import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class NotGrouped extends StatelessWidget {
  const NotGrouped({super.key});

  void _onJoinGroupTap(BuildContext context) => context.router.pushNamed(AppRoutes.groupPreferences);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final hasActiveSubscription = state.data.account?.hasActiveSubscription ?? false;
        final isOnTrial = state.data.account?.isOnTrial ?? true;

        final String title = !hasActiveSubscription || isOnTrial
            ? LocalizedTexts.supportGroupTrialSubscriptionNotGrouped.tr()
            : LocalizedTexts.supportGroupPaidSubscriptionNotGrouped.tr();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.w600('$title.', style: context.textTheme.bodySmall),
            const SizedBox(height: 18.0),
            if (!hasActiveSubscription || isOnTrial)
              CustomOutlinedButton.blueSmall(
                label: LocalizedTexts.joinAGroup.tr(),
                onPressed: () => _onJoinGroupTap(context),
              ),
          ],
        );
      },
    );
  }
}
