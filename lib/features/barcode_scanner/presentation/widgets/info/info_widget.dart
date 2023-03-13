import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/barcode_scanner/presentation/widgets/info/no_information.dart';
import 'package:loopcare_frontend/features/barcode_scanner/presentation/widgets/info/product_information.dart';

class QRCodeInfoWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const QRCodeInfoWidget({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 44, top: 16),
        child: ProductInformation(
          title: title,
        ),
      ),
    );
  }
}
