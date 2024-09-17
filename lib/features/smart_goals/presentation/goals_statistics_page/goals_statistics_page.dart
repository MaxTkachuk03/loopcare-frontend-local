import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_statistics_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goals_statistics_page/widgets/goals_stats_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class GoalsStatisticsPage extends StatefulWidget {
  const GoalsStatisticsPage({super.key});

  @override
  State<GoalsStatisticsPage> createState() => _GoalsStatisticsPageState();
}

class _GoalsStatisticsPageState extends State<GoalsStatisticsPage> {
  @override
  void initState() {
    super.initState();

    context
        .read<SmartGoalsStatisticsBloc>()
        .add(const SmartGoalsStatisticsEvent.getSmartGoalsStatistics());
  }

  void _onErrorRetryHandler() => context
      .read<SmartGoalsStatisticsBloc>()
      .add(const SmartGoalsStatisticsEvent.getSmartGoalsStatistics());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.smartGoalsMyGoals.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 28.0),
              CustomText.bitter600(
                LocalizedTexts.smartGoalsStatisticsTitle.tr(),
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 32.0),
              BlocBuilder<SmartGoalsStatisticsBloc, SmartGoalsStatisticsState>(
                builder: (BuildContext context, SmartGoalsStatisticsState state) {
                  return state.maybeMap(
                    loadind: (_) => const Loader(),
                    error: (s) => ErrorScreen(
                      error: s.data.error!,
                      onButtonPressed: _onErrorRetryHandler,
                    ),
                    orElse: () {
                      if (!state.data.hasAccomplishedCategories) {
                        return CustomText.w400(
                          LocalizedTexts.smartGoalsAccomplishedEmptyMessage.tr(),
                          style: context.textTheme.bodyMedium,
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: context.textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: '${state.data.totalAccomplishedGoalsAmount} ',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                      text: LocalizedTexts.smartGoalsAccomplishedInTotal.tr(),
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              const Expanded(child: GoalsStatsList()),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
