import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_page_mode.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class ConsultDoctorPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final ExtraActionPageMode mode;

  const ConsultDoctorPage({
    super.key,
    required this.mode,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  State<ConsultDoctorPage> createState() => _ConsultDoctorPageState();
}

class _ConsultDoctorPageState extends State<ConsultDoctorPage> {
  bool _isConsulted = false;

  void _onCompleteAfterLessonHandler(_) => context.router.pushNamed(AppRoutes.lessonComplete);

  void _onCompleteFromProfileHandler(_) {
    final userId = getIt<SharedStorageService>().account!.id;

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userConfirmedDoctorConsent,
      parameters: {
        AnalyticsParameters.userId: userId,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );

    context.router.pushNamed(AppRoutes.genderPreferences);
  }

  void _onCompleteLessonHandler() => widget.mode.map(
        afterLesson: _onCompleteAfterLessonHandler,
        userProfile: _onCompleteFromProfileHandler,
      );

  void _onConsentHandler(bool? value) {
    setState(() {
      _isConsulted = value ?? false;
    });
  }

  Widget _getBottomWidget() {
    return widget.mode.map(
      afterLesson: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.completeLesson.tr(),
            onPressed: _onCompleteLessonHandler,
          ),
          const SizedBox(height: 30.0),
        ],
      ),
      userProfile: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText.w700(
            LocalizedTexts.didYouCheckWithSpecialist.tr(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              CustomCheckbox.green(
                onChanged: _onConsentHandler,
                value: _isConsulted,
              ),
              CustomText.w400(
                LocalizedTexts.iConsultedTherapist.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.next.tr(),
            onPressed: _isConsulted ? _onCompleteLessonHandler : null,
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  _getScaffold(Widget body) => widget.mode.map(
        afterLesson: (_) => CustomScaffold(
          color: widget.streamType.lightestColor,
          appBar: CustomAppBar(
            backgroundColor: widget.streamType.regularColor,
            textTheme: widget.streamType.appBarTextTheme,
            title: LocalizedTexts.preferences.tr(),
            leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
          ),
          body: body,
        ),
        userProfile: (_) => CustomScaffold.blueLightest(
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.supportGroupPreferences.tr(),
            leading: CustomFilledIconButton.leadingBlueLighter(),
          ),
          body: body,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _getScaffold(CustomSafeArea(
      child: ScrollableContainer(
        child: MainContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 38.0),
                  CustomText.bitter500(
                    LocalizedTexts.consultYourTherapist.tr(),
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.consultYourTherapistBody1.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.consultYourTherapistBody2.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  CustomText.w400(
                    LocalizedTexts.consultYourTherapistBody3.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  widget.mode.map(
                    afterLesson: (_) => CustomText.w400(
                      LocalizedTexts.consultYourTherapistBody4.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    userProfile: (_) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
              _getBottomWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}
