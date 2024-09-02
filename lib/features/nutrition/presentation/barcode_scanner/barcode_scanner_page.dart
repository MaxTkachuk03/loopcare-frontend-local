import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/info_widget.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/no_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

@RoutePage()
class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlashOn = false;
  PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();

    _getCameraMermissionStatus();
  }

  _getCameraMermissionStatus() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    setState(() {
      _cameraPermissionStatus = status;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      HapticFeedback.mediumImpact();
      showModal(scanData.code ?? '');
    });
  }

  void showModal(String code) {
    controller?.pauseCamera().then(
          (value) => showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => QRCodeInfoWidget(code: code),
          ).whenComplete(
            () {
              controller?.resumeCamera();
            },
          ),
        );
  }

  void _flashPressed() {
    controller?.toggleFlash();

    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: CustomScaffold.greenLightest(
        appBar: CustomAppBar.green(
          title: LocalizedTexts.scanYourProduct.tr(),
          leading: CustomFilledIconButton.leadingGreenLighter(),
          actions: [
            IconButton(
              onPressed: _flashPressed,
              icon: Icon(isFlashOn ? Icons.flash_off : Icons.flash_on, color: AppColors.blueDarker),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_cameraPermissionStatus.isDenied || _cameraPermissionStatus.isPermanentlyDenied)
              const MainContainer(child: NoPermissions()),
            if (_cameraPermissionStatus.isGranted)
              Expanded(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.white,
                    borderLength: 32,
                    borderWidth: 6,
                    cutOutWidth: 260,
                    cutOutHeight: 200,
                  ),
                ),
              ),
            Expanded(
              child: MainContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.qrCodeSubtext_1.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.qrCodeSubtext_2.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.qrCodeSubtext_3.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
