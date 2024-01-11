import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';

class InformationDialog extends StatelessWidget {
  final String content;
  final String okText;
  final String cancelText;
  final void Function() onOkHandler;
  final void Function() onCancelHandler;

  const InformationDialog({
    super.key,
    required this.content,
    required this.okText,
    required this.onOkHandler,
    required this.cancelText,
    required this.onCancelHandler,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      actions: [
        CustomElevatedButton.blueFullWidth(
          onPressed: onOkHandler,
          label: okText,
        ),
        CustomElevatedButton.blueFullWidth(
          onPressed: onCancelHandler,
          label: cancelText,
        ),
      ],
    );
  }
}
