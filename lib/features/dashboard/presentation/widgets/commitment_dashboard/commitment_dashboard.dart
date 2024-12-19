import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/commitment/application/commitment_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CommitmentDashboard extends StatelessWidget {
  final DateTime selectedDay;

  const CommitmentDashboard({super.key, required this.selectedDay});

  void _onPressHandler(BuildContext context) {
    if (selectedDay.isFuture) return;

    context.router.pushNamed(AppRoutes.nutritionIntake);
  }

  void onErrorHandler(BuildContext context) =>
      context.read<CommitmentBloc>().add(CommitmentEvent.getCommitment(date: selectedDay));

  Color get _textColor => !selectedDay.isFuture ? AppColors.blueDarker : AppColors.greyLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommitmentBloc, CommitmentState>(
      builder: (context, state) {
        final totalCommitments = state.data.totalCommitments;
        final completedCommitments = state.data.completedCommitments;
        return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              DashboardCardTitle(
                onTap: () => _onPressHandler(context),
                highlightColor: AppColors.greenLightest,
                leadingIcon: AppIcons.commitment,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.commitment.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(color: _textColor),
                    ),
                  ],
                ),
                actionIcon: AppIcons.arrow,
                circleButton: false,
                editable: true,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) => state.data.isCommitmentUnlocked
                    ? const SizedBox.shrink()
                    : const Divider(color: AppColors.blueOffRegular),
              ),
              state.maybeMap(
                loading: (_) => const Loader(),
                error: (s) {
                  final error = s.data.error;

                  return ErrorScreen(error: error!, onButtonPressed: () => onErrorHandler(context));
                },
                orElse: () {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            NutritionIndicator.small(
                              color: AppColors.blueLightest,
                              label: '$completedCommitments/$totalCommitments',
                              progress: totalCommitments != 0
                                  ? completedCommitments / totalCommitments
                                  : 0.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            CustomText.w600(
                              LocalizedTexts.completeYourSurveys.tr(),
                              style: context.textTheme.titleSmall?.copyWith(color: _textColor),
                            ),
                          ],
                        ),
                        if (completedCommitments > 0 && completedCommitments != totalCommitments)
                          const ImageIcon(AppIcons.checkmark,
                              color: AppColors.blueDarker, size: 44),
                        if (completedCommitments >= totalCommitments)
                          Image.asset(
                            'assets/icons/achievements.png',
                            width: 44,
                            height: 44,
                            fit: BoxFit.contain,
                            colorBlendMode: BlendMode.modulate,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
