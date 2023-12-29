import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

extension SnackBarShortcuts on BuildContext {
  /// Show a error flash bar.
  Future<T?> showError<T>({
    required Widget content,
    FlashPosition position = FlashPosition.top,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(Icons.error_outline),
    Color? indicatorColor = const Color(0xFFE57373),
    FlashBuilder<T>? primaryActionBuilder,
  }) {
    return showFlash<T>(
      context: this,
      duration: duration,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: position,
          indicatorColor: indicatorColor,
          icon: icon,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: content,
          ),
          primaryAction: primaryActionBuilder?.call(context, controller),
        );
      },
    );
  }

  /// Show a success flash bar.
  Future<T?> showCustomSuccessBar<T>({
    required Widget content,
    FlashPosition position = FlashPosition.top,
    Duration duration = const Duration(seconds: 3),
    FlashBuilder<T>? primaryActionBuilder,
    List<Widget>? actions,
  }) {
    return showFlash<T>(
      context: this,
      duration: duration,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: position,
          icon: AppIcons.greenCheckmark,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: content,
          ),
          primaryAction: primaryActionBuilder?.call(context, controller),
          actions: actions,
        );
      },
    );
  }

  Future<T?> showSuccessBar<T>({
    required Widget content,
    FlashPosition position = FlashPosition.top,
    Duration duration = const Duration(seconds: 3),
    Color? indicatorColor = const Color(0xFF81C784),
    FlashBuilder<T>? primaryActionBuilder,
    List<Widget>? actions,
  }) {
    return showFlash<T>(
      context: this,
      duration: duration,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: position,
          indicatorColor: indicatorColor,
          icon: const Image(image: AppIcons.hexaDone),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: content,
          ),
          primaryAction: primaryActionBuilder?.call(context, controller),
          actions: actions,
        );
      },
    );
  }

  Future<T?> showFlashBar<T>({
    required String text,
    Color? background,
    VoidCallback? callback,
    Color? textColor,
    Widget? leadIcon,
    FlashPosition position = FlashPosition.top,
    Duration duration = const Duration(seconds: 3),
    FlashBuilder<T>? primaryActionBuilder,
    List<Widget>? actions,
  }) {
    return showFlash<T>(
      context: this,
      duration: duration,
      builder: (context, controller) {
        final size = MediaQuery.of(context).size;
        return FlashBar(
          controller: controller,
          position: position,
          content: SizedBox(
            width: size.width * 0.8718,
            child: Padding(
              padding: (leadIcon != null)
                  ? const EdgeInsets.only(left: 12, right: 24.0, top: 24.0, bottom: 24.0)
                  : const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (leadIcon != null) Padding(padding: const EdgeInsets.only(right: 8.0), child: leadIcon),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          primaryAction: primaryActionBuilder?.call(context, controller),
          actions: actions,
        );
      },
    );
  }
}

void showConnectionErrorMessage() {
  toast.Fluttertoast.cancel();
  toast.Fluttertoast.showToast(
    msg: LocalizedTexts.connectionLost.tr(),
    toastLength: toast.Toast.LENGTH_LONG,
    gravity: toast.ToastGravity.BOTTOM,
    fontSize: 14.0,
  );
}
