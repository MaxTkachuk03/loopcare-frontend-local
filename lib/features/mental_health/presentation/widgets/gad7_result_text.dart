import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_check_result_page.dart';
import 'package:url_launcher/url_launcher.dart';

class GAD7ResultText extends StatelessWidget {
  const GAD7ResultText({super.key});

  void _onUrlHandler(BuildContext context) async {
    final Uri launchUri = Uri.parse(psychologistConsultingLink);

    try {
      await launchUrl(launchUri);
    } catch (e) {
      _showError(context);
    }
  }

  void _showError(BuildContext context) =>
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.translation));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTestType = state.data.currentTest?.type;

        if (currentTestType == null) return const SizedBox.shrink();

        final interpretation = state.data.results[currentTestType]?.interpretation;

        return _getTextWidget(context, interpretation);
      },
    );
  }

  Widget _getTextWidget(BuildContext context, InterpretationType? interpretation) {
    switch (interpretation) {
      case InterpretationType.minimal:
        return Text(LocalizedTexts.gad7ResultMinimal.translation, style: Theme.of(context).textTheme.bodyLarge);
      case InterpretationType.mild:
        return Text(LocalizedTexts.gad7ResultMild.translation, style: Theme.of(context).textTheme.bodyLarge);
      case InterpretationType.moderate:
        return Text(LocalizedTexts.gad7ResultMedium.translation, style: Theme.of(context).textTheme.bodyLarge);
      case InterpretationType.high:
        return RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '${LocalizedTexts.gad7ResultHigh.translation} \n',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueAppBar),
              text: '$psychologistConsultingLink \n\n',
              recognizer: TapGestureRecognizer()..onTap = () => _onUrlHandler(context),
            ),
            TextSpan(
              text: LocalizedTexts.ifYouHaveSuicidalThoughts.translation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ]),
        );

      default:
        return const Text('');
    }
  }
}
