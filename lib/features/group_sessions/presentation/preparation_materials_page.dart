import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class PreparationMaterialsPage extends StatelessWidget {
  const PreparationMaterialsPage({super.key});

  Future<bool> _onWillPop(BuildContext context) {
    final topicState = context.read<TopicsBloc>().state;
    final sessionId = topicState.data.signedGroupSessionId ?? 0;
    final weekTopic = topicState.data.weekTopicName;

    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            FirebaseEvents.closedSessionPreparationMaterials,
            {
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

    AnalyticsEventService.instance.closedSessionPreparationMaterialsEvent(sessionId, weekTopic);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        final content = state.data.weekTopic?.materials.first.article;

        return WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: CustomScaffold.blueLightest(
            appBar: CustomAppBar.blue(
              title: LocalizedTexts.preparation.translation,
              subtitle: state.data.weekTopicName,
              leading: CustomFilledIconButton.leadingBlueLighter(),
            ),
            body: SafeArea(
              child: ScrollableContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 48.0),
                    if (content != null)
                      HtmlRenderer(
                        content: content,
                        textStyle: const TextStyle(fontSize: ThemeConstants.fontSize18),
                      ),
                    const SizedBox(height: 65.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
