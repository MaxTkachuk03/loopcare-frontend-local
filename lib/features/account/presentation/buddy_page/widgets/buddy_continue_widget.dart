import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/step_navigation_state.dart';

class BuddyContinueWidget extends StatefulWidget {
  final bool enable;

  final Function()? handler;

  const BuddyContinueWidget({
    super.key,
    required this.enable,
    this.handler,
  });

  @override
  State<BuddyContinueWidget> createState() => _BuddyContinueState();
}

class _BuddyContinueState extends State<BuddyContinueWidget> {
  void _onNextHandler() {
    final buddyNavigationState = StepNavigationState.of(context);
    widget.handler?.call();
    buddyNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CustomElevatedButton.blueFullWidth(
        onPressed: widget.enable ? () => _onNextHandler() : null,
        label: LocalizedTexts.next.tr(),
      ),
    );
  }
}
