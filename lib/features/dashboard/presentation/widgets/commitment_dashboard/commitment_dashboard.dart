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
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CommitmentDashboard extends StatefulWidget {
  final DateTime selectedDay;
  final bool isUnlocked;

  const CommitmentDashboard({super.key, required this.selectedDay, required this.isUnlocked});

  @override
  State<CommitmentDashboard> createState() => _CommitmentDashboardState();
}

class _CommitmentDashboardState extends State<CommitmentDashboard> {
  bool toggleArrowIcon = false;

  void toggleOnClick() {
    setState(() {
      toggleArrowIcon = !toggleArrowIcon;
    });
  }

  void _onPressHandler(BuildContext context) {
    if (widget.selectedDay.isFuture) return;

    context.router.pushNamed(AppRoutes.nutritionIntake).then(getPoolData);
  }

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

  void onErrorHandler(BuildContext context) =>
      context.read<CommitmentBloc>().add(CommitmentEvent.getCommitment(date: widget.selectedDay));

  Color get _textColor => !widget.selectedDay.isFuture ? AppColors.blueDarker : AppColors.greyLabel;

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
                onTap: widget.isUnlocked ? () => _onPressHandler(context) : () => toggleOnClick(),
                highlightColor: widget.isUnlocked ? AppColors.greenLightest : AppColors.white,
                leadingIcon: widget.isUnlocked ? AppIcons.commitment : AppIcons.commitmentLocked,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isUnlocked
                        ? CustomText.bitter600(
                            LocalizedTexts.commitment.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(color: _textColor),
                          )
                        : CustomText.bitter400(
                            LocalizedTexts.commitment.tr(),
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 20),
                          ),
                  ],
                ),
                actionIcon: widget.isUnlocked
                    ? AppIcons.arrow
                    : toggleArrowIcon
                        ? const AssetImage(AppIcons.upArrow)
                        : AppIcons.downArrow,
                circleButton: widget.isUnlocked ? true : false,
                editable: widget.isUnlocked ? true : !widget.selectedDay.isFuture,
              ),
              widget.isUnlocked
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          AppIcons.lockGoals,
                          const SizedBox(
                            width: 36,
                          ),
                          SizedBox(
                            width: 250,
                            child: CustomText.w400(
                              "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.commitmentUnlock.tr()}",
                              style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) => widget.isUnlocked
                      ? const Divider(color: AppColors.blueOffRegular, indent: 8.0, endIndent: 8.0)
                      : const SizedBox.shrink()),
              state.maybeMap(
                loading: (_) => const Loader(),
                error: (s) {
                  final error = s.data.error;

                  return ErrorScreen(error: error!, onButtonPressed: () => onErrorHandler(context));
                },
                orElse: () {
                  return !toggleArrowIcon && widget.isUnlocked
                      ? Padding(
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
                                    style:
                                        context.textTheme.titleSmall?.copyWith(color: _textColor),
                                  ),
                                ],
                              ),
                              if (completedCommitments > 0 &&
                                  completedCommitments != totalCommitments)
                                const ImageIcon(AppIcons.checkmark,
                                    color: AppColors.blueDarker, size: 44),
                              if (completedCommitments >= totalCommitments &&
                                  completedCommitments != 0)
                                Image.asset(
                                  AppIcons.achievements,
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.contain,
                                  colorBlendMode: BlendMode.modulate,
                                ),
                            ],
                          ),
                        )
                      : toggleArrowIcon && !widget.isUnlocked
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 330,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomText.w400(
                                      maxLines: 10,
                                      LocalizedTexts.commitmentDescription.tr(),
                                      style:
                                          const TextStyle(color: AppColors.greyLight, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
