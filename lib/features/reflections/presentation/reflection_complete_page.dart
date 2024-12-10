import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class ReflectionCompletePage extends StatefulWidget {
  final RiverModuleStreamType streamType;

  const ReflectionCompletePage({super.key, this.streamType = RiverModuleStreamType.psychology});

  @override
  State<ReflectionCompletePage> createState() => _ReflectionCompletePageState();
}

class _ReflectionCompletePageState extends State<ReflectionCompletePage> {
  final usageAnalytics = UsageAnalytics();

  @override
  void initState() {
    super.initState();

    final reflection = context.read<ReflectionsBloc>().state.data.activeReflection;
    final riverModule = context.read<RiverBloc>().state.data.activeModule;

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.reflectionCompleted,
      attributes: {
        UsageAnalyticsAttributes.reflectionId: reflection?.id,
        UsageAnalyticsAttributes.reflectionTitle: reflection?.title,
        UsageAnalyticsAttributes.reflectionPool: riverModule?.title,
      },
    );
  }

  void _onPressHandler(BuildContext context) {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: widget.streamType.offRegularColor,
      appBar: CustomAppBar(
        backgroundColor: widget.streamType.regularColor,
        textTheme: widget.streamType.appBarTextTheme,
        title: LocalizedTexts.lesson.tr(),
        leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UnderAppbar.petrol(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                              backgroundColor: AppColors.greenRegular,
                              child: Icon(Icons.check, size: 24, color: AppColors.white),
                            ),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              LocalizedTexts.assignmentCompleted.tr(),
                              style:
                                  context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  MainContainer(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.petrolLightest,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: BlocBuilder<ReflectionsBloc, ReflectionsState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoryLabel.reflection(),
                              const SizedBox(height: 20.0),
                              CustomText.bitter600(
                                state.data.activeReflection?.title ?? '',
                                style: context.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                LocalizedTexts.assignmentCompleteDescription.tr(),
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MainContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: () => _onPressHandler(context),
                    label: LocalizedTexts.complete.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
