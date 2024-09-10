import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/barcode_scanner_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/no_information.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/product_information.dart';

class QRCodeInfoWidget extends StatefulWidget {
  final String code;

  const QRCodeInfoWidget({super.key, required this.code});

  @override
  State<QRCodeInfoWidget> createState() => _QRCodeInfoWidgetState();
}

class _QRCodeInfoWidgetState extends State<QRCodeInfoWidget> {
  @override
  void initState() {
    super.initState();

    context.read<BarcodeScannerBloc>().add((BarcodeScannerEvent.getInformation(widget.code)));

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.barcodeScanned,
      parameters: {
        AnalyticsParameters.value: widget.code,
        AnalyticsParameters.failedAttempt: widget.code.isEmpty ? 'true' : 'false',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeScannerBloc, BarcodeScannerState>(
      builder: (context, state) {
        return state.maybeMap(
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
                padding: EdgeInsets.only(left: 44, right: 44, bottom: 44, top: 16),
                child: NoInformation(),
              ),
            );
          },
          loaded: (successState) {
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
                padding: const EdgeInsets.only(left: 44, right: 44, bottom: 44, top: 16),
                child: ProductInformation(
                  isReady: successState.data.foodItem != null,
                  title:
                      '${successState.data.foodItem?.brandName} ${successState.data.foodItem?.foodName}',
                  calories: successState.data.foodItem?.servings.first.calories.toString() ?? '0',
                  perServing:
                      '${successState.data.foodItem?.servings.first.metricServingAmount} ${successState.data.foodItem?.servings.first.metricServingUnit}',
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
                padding: const EdgeInsets.only(left: 44, right: 44, bottom: 44, top: 16),
                child: Container(),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
