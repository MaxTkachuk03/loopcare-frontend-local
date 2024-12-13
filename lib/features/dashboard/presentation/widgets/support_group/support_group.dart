import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/looking_for_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/no_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/not_grouped.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SupportGroup extends StatefulWidget {
  final bool locked;
  const SupportGroup({super.key, required this.locked});

  @override
  State<SupportGroup> createState() => _SupportGroupState();
}

class _SupportGroupState extends State<SupportGroup> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
  }

  void onPressHandler() => context.router.pushNamed(AppRoutes.groupPreferences);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCardTitle(
              onTap: () {
                if (widget.locked) {
                  onPressHandler();
                } else {
                  toggleOnClick();
                }
              },
              highlightColor: widget.locked ? AppColors.orangeLightest : AppColors.white,
              leadingIcon:
                  widget.locked ? AppIcons.customSupportGroup : AppIcons.customSupportGroupGrey,
              title: widget.locked
                  ? CustomText.bitter600(
                      LocalizedTexts.supportGroup.tr(),
                      style: context.textTheme.headlineSmall,
                    )
                  : CustomText.bitter400(
                      LocalizedTexts.supportGroup.tr(),
                      style: context.textTheme.headlineSmall,
                    ),
              actionIcon: widget.locked
                  ? AppIcons.arrow
                  : onClick
                      ? const AssetImage(AppIcons.upArrow)
                      : AppIcons.downArrow,
              circleButton: widget.locked ? false : true,
            ),
            widget.locked
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
                            "${LocalizedTexts.featureUnlocksAtPool.tr()} #${LocalizedTexts.supportGroup.tr()}",
                            style: const TextStyle(color: AppColors.blueDarker),
                          ),
                        ),
                      ],
                    ),
                  ),
            onClick
                ? Container(
                    margin: const EdgeInsets.only(left: 70),
                    width: 250,
                    child: CustomText.w400(
                      maxLines: 10,
                      LocalizedTexts.supportGroupDescription.tr(),
                    ),
                  )
                : Container(),
            widget.locked
                ? const Divider(
                    color: AppColors.blueLighter,
                    indent: 8.0,
                    endIndent: 8.0,
                  )
                : const SizedBox(),
            widget.locked ? const SizedBox(height: 4.0) : const SizedBox(),
            widget.locked
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        switch (state.data.groupingState) {
                          case UserGroupingState.refused:
                          case UserGroupingState.unlockedPreferences:
                          case UserGroupingState.left:
                            return const NotGrouped();
                          case UserGroupingState.waitingInPool:
                          case UserGroupingState.loopedOnGenderPreferences:
                            return const LookingForGroup();
                          case UserGroupingState.grouped:
                            return const Grouped();
                          case UserGroupingState.noGroup:
                            return const NoGroup();
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
