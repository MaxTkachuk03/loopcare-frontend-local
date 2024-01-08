import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class ErrorScreen extends StatelessWidget {
  final RequestError? error;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool smallVersion;

  const ErrorScreen({
    super.key,
    this.error,
    this.buttonText,
    this.onButtonPressed,
    this.smallVersion = false,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      ErrorTypes errorType;

      errorType = error!.maybeWhen(
        requestCancelled: (error) => ErrorTypes.requestCancelled,
        orElse: () => ErrorTypes.somethingWentWrong,
        socketException: (_) => ErrorTypes.noInternetConnection,
      );

      if (errorType.isRequestCancelledType) return const SizedBox(height: 0.0);

      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (errorType.isSomethingWentWrongType)
                smallVersion ? AppImages.oepsSmall : AppImages.oepsBig
              else
                smallVersion ? AppImages.noConnectionSmall : AppImages.noConnectionBig,
              CustomText.bitter600(
                errorType.isSomethingWentWrongType
                    ? LocalizedTexts.oeps.translation
                    : LocalizedTexts.noConnectionTitle.translation,
                style: smallVersion ? context.textTheme.bodyLarge : context.textTheme.displayLarge,
              ),
              const SizedBox(height: 8.0),
              CustomText.w400(
                errorType.isSomethingWentWrongType
                    ? LocalizedTexts.somethingWentWrong.translation
                    : LocalizedTexts.noConnectionText.translation,
                style: context.textTheme.bodySmall,
              ),
              onButtonPressed == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: CustomOutlinedButton.blue(
                        onPressed: onButtonPressed,
                        label: buttonText ?? LocalizedTexts.retry.translation,
                      ),
                    ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox(height: 0.0);
    }
  }
}

enum ErrorTypes {
  somethingWentWrong,
  noInternetConnection,
  requestCancelled,
}

extension on ErrorTypes {
  bool get isSomethingWentWrongType => this == ErrorTypes.somethingWentWrong;

  bool get isRequestCancelledType => this == ErrorTypes.requestCancelled;
}
