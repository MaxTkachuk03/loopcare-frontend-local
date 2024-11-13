import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class LookingForGroup extends StatelessWidget {
  const LookingForGroup({super.key});

  void _onMoreInfoPressed(BuildContext context) =>
      context.router.pushNamed(AppRoutes.groupPreferences);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(
          LocalizedTexts.findingMatchingGroup.tr(),
          style: context.textTheme.bodyLarge,
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final groupingStartedAt = state.data.groupingStartedAt;

            if (groupingStartedAt == null) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.w400(
                  '${LocalizedTexts.weAreLookingForAGroupSince.tr()} ${groupingStartedAt.fullDateWithYear}.',
                  style: context.textTheme.bodySmall,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 18.0),
        CustomOutlinedButton.blueSmall(
          label: LocalizedTexts.moreInformationInPreferences.tr(),
          onPressed: () => _onMoreInfoPressed(context),
        ),
      ],
    );
  }
}
