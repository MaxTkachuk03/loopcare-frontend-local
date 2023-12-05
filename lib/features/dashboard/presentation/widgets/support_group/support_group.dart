import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
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
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => onPressHandler(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(image: AppIcons.supportGroup),
                        const SizedBox(width: 24.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalizedTexts.supportGroup.translation,
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontFamily: ThemeConstants.bitterFontFamily,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ImageIcon(
                    AppIcons.arrow,
                    color: AppColors.greyLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(color: AppColors.yellowLight),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                switch (state.groupingState) {
                  case UserGroupingState.locked:
                    return const LessonsUncompleted();
                  case UserGroupingState.refused:
                  case UserGroupingState.notGrouped:
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
            )
          ],
        ),
      ),
    );
  }
}
