import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class ErrorScreen extends StatelessWidget {
  final RequestError error;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool smallVersion;

  const ErrorScreen({
    super.key,
    required this.error,
    this.buttonText,
    this.onButtonPressed,
    this.smallVersion = false,
  });

  Widget _getIcon() {
    return error.maybeWhen(
      requestCancelled: (error) => AppImages.noConnectionSmall,
      socketException: (_) => AppImages.noConnectionSmall,
      orElse: () => AppImages.oepsSmall,
    );
  }

  String _getTitle() {
    return error.maybeWhen(
      requestCancelled: (error) => LocalizedTexts.noConnectionTitle.tr(),
      orElse: () => LocalizedTexts.oeps.tr(),
      socketException: (_) => LocalizedTexts.noConnectionTitle.tr(),
    );
  }

  String _getDescription() {
    return error.maybeWhen(
      requestCancelled: (error) => LocalizedTexts.noConnectionText.tr(),
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
      socketException: (_) => LocalizedTexts.noConnectionText.tr(),
      notFound: (_) => LocalizedTexts.invalidIngridientText.tr(),
    );
  }

  Widget _getButton() {
    return error.maybeWhen(
      notFound: (_) => const SizedBox.shrink(),
      orElse: () => Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: CustomOutlinedButton.blue(
          onPressed: onButtonPressed,
          label: buttonText ?? LocalizedTexts.retry.tr(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ErrorTypes errorType;

    errorType = error.maybeWhen(
      requestCancelled: (error) => ErrorTypes.requestCancelled,
      orElse: () => ErrorTypes.somethingWentWrong,
    );

    if (errorType == ErrorTypes.requestCancelled) return const SizedBox(height: 0.0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getIcon(),
            SizedBox(height: smallVersion ? 0.0 : 16.0),
            CustomText.bitter600(
              _getTitle(),
              style: smallVersion ? context.textTheme.bodyLarge : context.textTheme.displayLarge,
            ),
            SizedBox(height: smallVersion ? 8.0 : 16.0),
            CustomText.w400(
              _getDescription(),
              style: context.textTheme.bodySmall,
            ),
            onButtonPressed == null ? const SizedBox.shrink() : _getButton(),
          ],
        ),
      ),
    );
  }
}

enum ErrorTypes {
  somethingWentWrong,
  noInternetConnection,
  requestCancelled,
}
