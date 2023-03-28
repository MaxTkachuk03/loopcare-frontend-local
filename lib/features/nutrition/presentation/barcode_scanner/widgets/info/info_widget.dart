import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/barcode_scanner_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/info/no_information.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/info/product_information.dart';

class QRCodeInfoWidget extends StatefulWidget {
  final String code;

  const QRCodeInfoWidget({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  State<QRCodeInfoWidget> createState() => _QRCodeInfoWidgetState();
}

class _QRCodeInfoWidgetState extends State<QRCodeInfoWidget> {
  @override
  void initState() {
    context.read<BarcodeScannerBloc>().add(
          (BarcodeScannerEvent.getInformation(widget.code)),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeScannerBloc, BarcodeScannerState>(
      builder: (context, state) {
        return state.map(
          error: (errorState) {
            return Container(
              height: 400,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 44, right: 44, bottom: 44, top: 16),
                child: NoInformation(),
              ),
            );
          },
          success: (successState) {
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
                padding: const EdgeInsets.only(
                    left: 44, right: 44, bottom: 44, top: 16),
                child: ProductInformation(
                  isReady: successState.foodItem != null,
                  title:
                      '${successState.foodItem?.brandName} ${successState.foodItem?.foodName}',
                  calories: successState.foodItem?.servings.first.calories
                          .toString() ??
                      '0',
                  perServing:
                      '${successState.foodItem?.servings.first.metricServingAmount} ${successState.foodItem?.servings.first.metricServingUnit}',
                ),
              ),
            );
          },
          loading: (_) {
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
                padding: const EdgeInsets.only(
                    left: 44, right: 44, bottom: 44, top: 16),
                child: Container(),
              ),
            );
          },
        );
      },
    );
  }
}
