import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScannerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final QRViewController? controller;
  const BarcodeScannerAppBar({
    super.key,
    required this.controller,
  });

  @override
  State<BarcodeScannerAppBar> createState() => _BarcodeScannerAppBarState();

  @override
  Size get preferredSize => Size(56, AppBar().preferredSize.height);
}

class _BarcodeScannerAppBarState extends State<BarcodeScannerAppBar> {
  bool isFlashOn = false;

  void _flashPressed() async {
    await widget.controller?.toggleFlash();
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlueAppBar(
      title: LocalizedTexts.scanYourProduct.tr(),
      leading: IconButton(
        onPressed: _flashPressed,
        icon: isFlashOn
            ? const Icon(Icons.flash_off, color: AppColors.white)
            : const Icon(Icons.flash_on, color: AppColors.white),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: const Icon(Icons.close, color: AppColors.white),
          ),
        )
      ],
    );
  }
}
