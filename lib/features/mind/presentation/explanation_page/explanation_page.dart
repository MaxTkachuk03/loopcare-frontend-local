import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

class ExplanationPage extends StatelessWidget {
  const ExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = LocalizedTexts.mindTraining.tr();
    final explanation = bloc.state.data.mindInfo!.explanation;
    final url = bloc.state.data.mindInfo!.explanation.preview;

    return MindContentScreen.explanation(
      title: title,
      steps: [explanation],
      contentTitle: title,
      url: url,
      onComplete: context.router.pop,
    );
  }
}
