import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/video_session/domain/zoom_errors_mapper.dart';

class ErrorDialog extends StatelessWidget {
  final String errorText;
  final void Function() onErrorHandler;

  const ErrorDialog({super.key, required this.errorText, required this.onErrorHandler});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText.w600(LocalizedTexts.error.tr()),
      content: CustomText.w400(ZoomErrorMapper.getLocalizedErrorText(errorText)),
      actions: [
        TextButton(
          onPressed: onErrorHandler,
          child: CustomText.w600(LocalizedTexts.ok.tr().toUpperCase()),
        ),
      ],
    );
  }
}
