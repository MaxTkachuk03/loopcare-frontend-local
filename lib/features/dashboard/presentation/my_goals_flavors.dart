import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

import '../../../../../core/presentation/app_bar/custom_app_bar.dart';
import '../../../../../core/presentation/buttons/custom_filled_icon_button.dart';
import '../../../../../core/presentation/custom_safe_area.dart';
import '../../../../../core/presentation/icon_images/app_icons.dart';
import '../../../../../core/presentation/scaffold/custom_scaffold.dart';
import '../../../../../core/presentation/text/custom_text.dart';
import '../../../../../core/presentation/themes/themes.dart';
import '../../../../../localization/service/localized_texts.dart';
import '../../../core/presentation/routes/app_router.dart';
import 'widgets/dashboard_card_title/dashboard_card_title.dart';

@RoutePage()
class MyGoalsFlavors extends StatefulWidget {
  const MyGoalsFlavors({super.key});

  @override
  State<MyGoalsFlavors> createState() => _MyGoalsFlavorsState();
}

class _MyGoalsFlavorsState extends State<MyGoalsFlavors> {
  int? selectedIndex;

  final Map<SupportAppStreams, Map<String, dynamic>> _goals = {
    SupportAppStreams.psychology: {
      'title': LocalizedTexts.psychology.tr(),
      'icon': AppIcons.psychologyGoals,
      'value': "psychology"
    },
    SupportAppStreams.nutrition: {
      'title': LocalizedTexts.nutrition.tr(),
      'icon': AppIcons.customDashboardSmartGoals,
      "value": 'nutrition'
    },
    SupportAppStreams.physicalActivity: {
      'title': LocalizedTexts.physicalActivity.tr(),
      'icon': AppIcons.physicalActivityGoals,
      "value": 'physicalActivity'
    },
    SupportAppStreams.community: {
      'title': LocalizedTexts.community.tr(),
      'icon': AppIcons.communityGoals,
      "value": 'community'
    },
    SupportAppStreams.medical: {
      'title': LocalizedTexts.medicalInsights.tr(),
      'icon': AppIcons.mindInsightsGoals,
      "value": 'medical'
    },
  };

  void _onTapHandler(BuildContext context, int index, Map<String, dynamic> goal) {
    setState(() {
      selectedIndex = index;
    });
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   // Check if the widget is still mounted before navigating
    //   if (mounted) {
    context.router.push(SelectGoalsCategoryRoute(stream: goal['value'].toString()));
    //     if (kDebugMode) {
    //       print('${goal['title']} tapped');
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.smartGoalsMyGoals.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
        actions: const [],
      ),
      body: CustomSafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(21.0, 28.0, 20.0, 21.0),
                child: CustomText.bitter600(
                  LocalizedTexts.selectAStream.tr(),
                  style: context.textTheme.displayMedium,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final stream = SupportAppStreams.values[index];
                  final goal = _goals[stream]!;

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () => _onTapHandler(context, index, goal),
                      child: AnimatedScale(
                        scale: selectedIndex == index ? 1.01 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DashboardCardTitle(
                              highlightColor: AppColors.greenLightest,
                              leadingIcon: goal['icon'],
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText.bitter600(
                                    goal['title'].toString().capitalize(),
                                    style: context.textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                              actionIcon: AppIcons.arrow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _goals.length,
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  context.router.pushNamed(AppRoutes.deleteWeeklyGoals);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(21.0, 28.0, 20.0, 21.0),
                  child: Row(
                    children: [
                      AppIcons.deleteGoals,
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: CustomText.w700(
                          LocalizedTexts.deleteGoals.tr(),
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueDarkest,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum SupportAppStreams {
  psychology,
  nutrition,
  physicalActivity,
  community,
  medical,
}
