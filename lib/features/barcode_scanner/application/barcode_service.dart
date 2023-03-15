import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/barcode_scanner/application/dto/barcode_information_response.dart';

abstract class BarcodeService {
  Future<Either<RequestError, BarcodeInformationResponse>> getInformation(
      String barCode);
}
