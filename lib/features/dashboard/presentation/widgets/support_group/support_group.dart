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
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/lessons_uncompleted.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/looking_for_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/no_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/no_timeslots.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/not_grouped.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class SupportGroup extends StatefulWidget {
  const SupportGroup({super.key});

  @override
  State<SupportGroup> createState() => _SupportGroupState();
}

class _SupportGroupState extends State<SupportGroup> {
  @override
  void initState() {
    super.initState();

    context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics());
  }

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

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
              onTap: () => onPressHandler(context),
              highlightColor: AppColors.orangeLightest,
              leadingIcon: AppIcons.customSupportGroup,
              title: CustomText.bitter600(
                LocalizedTexts.supportGroup.tr(),
                style: context.textTheme.headlineSmall,
              ),
              actionIcon: AppIcons.arrow,
              circleButton: false,
            ),
            const Divider(
              color: AppColors.blueOffRegular,
              indent: 8.0,
              endIndent: 8.0,
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  switch (state.data.groupingState) {
                    case UserGroupingState.locked:
                      return const LessonsUncompleted();
                    case UserGroupingState.refused:
                    case UserGroupingState.unlockedPreferences:
                    case UserGroupingState.left:
                      return const NotGrouped();
                    case UserGroupingState.waitingInPool:
                    case UserGroupingState.loopedOnGenderPreferences:
                      return const LookingForGroup();
                    case UserGroupingState.grouped:
                      return const Grouped();
                    case UserGroupingState.noTS:
                      return const NoTimeslots();
                    case UserGroupingState.noGroup:
                      return const NoGroup();
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
