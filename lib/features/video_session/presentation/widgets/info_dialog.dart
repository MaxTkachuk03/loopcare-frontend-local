import 'package:flutter/material.dart';

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
        TextButton(
          onPressed: onOkHandler,
          child: Text(okText),
        ),
        TextButton(
          onPressed: onCancelHandler,
          child: Text(cancelText),
        ),
      ],
    );
  }
}
