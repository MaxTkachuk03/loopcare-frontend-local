import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

@RoutePage()
class ExplanationTechniquePage extends StatefulWidget {
  const ExplanationTechniquePage({super.key});

  @override
  State<ExplanationTechniquePage> createState() => _ExplanationTechniquePageState();
}

class _ExplanationTechniquePageState extends State<ExplanationTechniquePage>
    with MindAnalyticsMixin {
  @override
  void initState() {
    super.initState();
    techniqueId = context.read<MindBloc>().state.data.currentTechnique!.id;

    track(AnalyticsEvents.mindTechniqueExplanation);
  }

  @override
  void dispose() {
    track(AnalyticsEvents.mindCloseTechniqueExplanation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final explanation = bloc.state.data.currentTechnique!.explanation;

    return MindContentScreen.explanation(
      title: title,
      steps: [explanation],
      contentTitle: title,
      onComplete: context.router.maybePop,
    );
  }
}
