import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';

class ErrorScreen extends StatelessWidget {
  final RequestError? error;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool smallVersion;

  const ErrorScreen({
    Key? key,
    this.error,
    this.buttonText,
    this.onButtonPressed,
    this.smallVersion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      ErrorTypes errorType;

      errorType = error!.maybeWhen(
        orElse: () => ErrorTypes.somethingWentWrong,
        socketException: (_) => ErrorTypes.noInternetConnection,
      );

      return Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (errorType.isSomethingWentWrongType)
              Image(image: AppImages.oeps, width: smallVersion ? 60 : 120, height: smallVersion ? 60 : 120)
            else
              Image(
                  image: AppImages.noConnection,
                  width: smallVersion ? 60 : 120,
                  height: smallVersion ? 60 : 120),
            Text(
              errorType.isSomethingWentWrongType
                  ? LocalizedTexts.oeps.translation
                  : LocalizedTexts.noConnectionTitle.translation,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: errorType.isSomethingWentWrongType ? AppColors.orange : AppColors.blueMid,
                  fontFamily: ThemeConstants.bitterFontFamily,
                  fontSize: smallVersion ? ThemeConstants.fontSize18 : ThemeConstants.fontSize28),
            ),
            const SizedBox(height: 8.0),
            Text(
              errorType.isSomethingWentWrongType
                  ? LocalizedTexts.somethingWentWrong.translation
                  : LocalizedTexts.noConnectionText.translation,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontSize: smallVersion ? ThemeConstants.fontSize10 : ThemeConstants.fontSize16,
                  ),
            ),
            onButtonPressed == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: OutlinedRoundedButton(
                      onPressed: onButtonPressed,
                      text: buttonText ?? LocalizedTexts.retry.translation,
                      radius: 20,
                      textPadding: 40,
                    ),
                  ),
          ],
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
}

extension on ErrorTypes {
  bool get isSomethingWentWrongType => this == ErrorTypes.somethingWentWrong;
}
