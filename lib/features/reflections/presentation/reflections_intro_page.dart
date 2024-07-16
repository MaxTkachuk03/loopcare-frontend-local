import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class ReflectionsIntroPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final Reflection reflectionItem;
  final bool fromDashboard;

  const ReflectionsIntroPage({
    super.key,
    required this.reflectionItem,
    required this.fromDashboard,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  State<ReflectionsIntroPage> createState() => _ReflectionsIntroPageState();
}

class _ReflectionsIntroPageState extends State<ReflectionsIntroPage> {
  late ReflectionsBloc _reflectionsBloc;

  @override
  void initState() {
    super.initState();

    context
        .read<ReflectionsBloc>()
        .add(ReflectionsEvent.setActiveReflection(reflection: widget.reflectionItem));

    AnalyticsEventService.instance.userOpenedAssignment(widget.reflectionItem);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reflectionsBloc = context.read<ReflectionsBloc>();
  }

  void _onSeeLessonHandler() {
    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.getLessonContent(lessonId: widget.reflectionItem.lessonId));

    context.router.pushNamed('/lesson/${widget.reflectionItem.lessonId}');
  }

  void _onStart() {
    context.router.push(ReflectionQuestionRoute(
      step: 0,
      fromDashboard: widget.fromDashboard,
      streamType: widget.streamType,
    ));
  }

  Future<bool> _onWillPopHandler() {
    AnalyticsEventService.instance.finalizeAssignment(
      FirebaseEvents.userLeftAssignment,
      widget.reflectionItem,
      widget.fromDashboard,
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopHandler,
      child: CustomScaffold(
        color: widget.streamType.lightestColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: widget.streamType.appBarTextTheme,
          title: LocalizedTexts.reflection.tr(),
          subtitle: LocalizedTexts.introduction.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      SizedBox(
                        height: 365,
                        child: NetworkImageWithCache(url: widget.reflectionItem.image),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel.reflection(),
                      const SizedBox(height: 18.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.bitter600(
                            widget.reflectionItem.title,
                            style: context.textTheme.displayLarge,
                          ),
                          const SizedBox(height: 18.0),
                          CustomText.w400(
                            widget.reflectionItem.instruction,
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18.0),
                      CustomOutlinedButton.blueSmall(
                        onPressed: _onSeeLessonHandler,
                        label: LocalizedTexts.seeLesson.tr(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
                    child: CustomElevatedButton.blueFullWidth(
                      onPressed: _onStart,
                      label: LocalizedTexts.letsGo.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reflectionsBloc.add(const ReflectionsEvent.resetActiveReflection());

    super.dispose();
  }
}
