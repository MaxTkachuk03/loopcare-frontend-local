import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class LookingForGroup extends StatelessWidget {
  const LookingForGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w600(
          LocalizedTexts.weWillNotifyYouAboutGroup.tr(),
          style: context.textTheme.bodySmall,
        ),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final groupingStartedAt = state.groupingStartedAt;

            if (groupingStartedAt == null) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.w400(
                  LocalizedTexts.weAreLookingForAGroupSince.translation,
                  style: context.textTheme.bodySmall,
                ),
                CustomText.w400(
                  '${groupingStartedAt.fullDateWithYear}.',
                  style: context.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        InkWell(
          onTap: () => _onMoreInfoPressed(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1,
                color: AppColors.yellowLight,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.w600(
                  LocalizedTexts.moreInformationInPreferences.tr(),
                  style: context.textTheme.bodySmall,
                ),
                const ImageIcon(
                  AppIcons.arrow,
                  color: AppColors.blueDarker,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _onMoreInfoPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }
}
