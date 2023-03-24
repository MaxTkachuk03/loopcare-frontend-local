import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/barcode_scanner_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/info/info_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  Barcode? barCodeResult;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        HapticFeedback.mediumImpact();
        barCodeResult = scanData;
        showModal();
      });
    });
  }

  void _onPermissionSet(
    BuildContext context,
    QRViewController ctrl,
    bool p,
  ) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showModal() {
    controller?.pauseCamera().then(
          (value) => showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return QRCodeInfoWidget(code: barCodeResult?.code ?? '');
            },
          ).whenComplete(() {
            controller?.resumeCamera();
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BarcodeScannerAppBar(controller: controller),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
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
                    onPermissionSet: (ctrl, p) => _onPermissionSet(
                      context,
                      ctrl,
                      p,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        BulletListItem(
                          text: Text(
                            LocalizedTexts.qrCodeSubtext_1.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          bulletSize: 18.0,
                        ),
                        BulletListItem(
                          text: Text(
                            LocalizedTexts.qrCodeSubtext_2.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          bulletSize: 18.0,
                        ),
                        BulletListItem(
                          text: Text(
                            LocalizedTexts.qrCodeSubtext_3.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          bulletSize: 18.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
