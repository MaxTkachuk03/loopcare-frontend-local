import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';

void showAppSnackBar({
  required BuildContext context,
  required String text,
  Color? background,
  VoidCallback? callback,
  Color? textColor,
  Widget? leadIcon,
}) async {
  final size = MediaQuery.of(context).size;

  await showFlash(
    context: context,
    duration: const Duration(
      seconds: 5,
    ),
    builder: (context, FlashController controller) {
      return Flash(
        controller: controller,
        alignment: Alignment.topCenter,
        backgroundColor: background ?? AppColors.greenMid,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadows: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0.0, 0.0),
            blurRadius: 12,
          ),
        ],
        child: SizedBox(
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
      );
    },
  );

  callback?.call();
}
