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

  const ErrorScreen({
    super.key,
    required this.error,
    this.buttonText,
    this.onButtonPressed,
  });

  Widget _getIcon() {
    return error.maybeWhen(
      requestCancelled: (_) => AppImages.noConnectionSmall,
      socketException: (_) => AppImages.noConnectionSmall,
      orElse: () => AppImages.oepsSmall,
    );
  }

  String _getTitle() {
    return error.maybeWhen(
      requestCancelled: (_) => LocalizedTexts.errorNoConnectionTitle.tr(),
      orElse: () => LocalizedTexts.errorOeps.tr(),
      socketException: (_) => LocalizedTexts.errorNoConnectionTitle.tr(),
    );
  }

  String _getDescription() {
    return error.maybeWhen(
      requestCancelled: (_) => LocalizedTexts.errorNoConnectionText.tr(),
      orElse: () => LocalizedTexts.errorSomethingWentWrong.tr(),
      socketException: (_) => LocalizedTexts.errorNoConnectionText.tr(),
      notFound: (error) {
        if (error.message == LocalizedTexts.errorValidationServingIdEmpty) {
          return error.message?.tr() ?? LocalizedTexts.errorInvalidIngredientText.tr();
        }
        return LocalizedTexts.errorSomethingWentWrong.tr();
      },
    );
  }

  Widget _getRetryButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomOutlinedButton.blue(
        onPressed: onButtonPressed,
        label: buttonText ?? LocalizedTexts.errorRetry.tr(),
      ),
    );
  }

  Widget _getButton() {
    return error.maybeWhen(
      notFound: (error) {
        if (error.message == LocalizedTexts.errorValidationServingIdEmpty) {
          return const SizedBox.shrink();
        }
        return _getRetryButton();
      },
      orElse: () => _getRetryButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ErrorTypes errorType;

    errorType = error.maybeWhen(
      requestCancelled: (_) => ErrorTypes.requestCancelled,
      orElse: () => ErrorTypes.somethingWentWrong,
    );

    if (errorType == ErrorTypes.requestCancelled) return const SizedBox(height: 0.0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getIcon(),
            const SizedBox(height: 12.0),
            CustomText.bitter600(_getTitle(), style: context.textTheme.displayLarge),
            const SizedBox(height: 12.0),
            CustomText.w400(_getDescription(), style: context.textTheme.bodySmall),
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
