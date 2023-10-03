import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_errors_mapper.dart';

class ErrorDialog extends StatelessWidget {
  final String errorText;
  final void Function() onErrorHandler;

  const ErrorDialog({super.key, required this.errorText, required this.onErrorHandler});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocalizedTexts.error).tr(),
      content: Text(ZoomErrorMapper.getLocalizedErrorText(errorText)),
      actions: [
        TextButton(
          onPressed: onErrorHandler,
          child: Text(LocalizedTexts.ok.tr().toUpperCase()),
        ),
      ],
    );
  }
}
