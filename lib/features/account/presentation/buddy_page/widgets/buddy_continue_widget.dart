import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class BuddyContinueWidget extends StatefulWidget {
  final bool enable;

  const BuddyContinueWidget({super.key, required this.enable});

  @override
  State<BuddyContinueWidget> createState() => _BuddyContinueState();
}

class _BuddyContinueState extends State<BuddyContinueWidget> {
  void _onNextHandler() {
    final buddyNavigationState = StepNavigationState.of(context);

    buddyNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.blueFullWidth(
      onPressed: widget.enable ? () => _onNextHandler() : null,
      label: LocalizedTexts.continueBtn.tr(),
    );
  }
}
