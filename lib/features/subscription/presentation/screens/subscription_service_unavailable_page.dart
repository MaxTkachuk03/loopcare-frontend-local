import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionServiceUnavailablePage extends StatelessWidget {
  const SubscriptionServiceUnavailablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: CustomText.bitter600(
            LocalizedTexts.errorSubscriptionServiceUnavailable.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
