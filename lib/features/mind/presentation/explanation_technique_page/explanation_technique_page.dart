import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

class ExplanationTechniquePage extends StatelessWidget {
  const ExplanationTechniquePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final explanation = bloc.state.data.currentTechnique!.explanation;
    final url = bloc.state.data.currentTechnique!.explanation.preview;

    return MindContentScreen.explanation(
      title: title,
      steps: [explanation],
      contentTitle: title,
      url: url,
      onComplete: context.router.pop,
    );
  }
}
