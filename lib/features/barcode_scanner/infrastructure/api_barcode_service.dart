import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/barcode_scanner/application/barcode_service.dart';
import 'package:loopcare_frontend/features/barcode_scanner/application/dto/barcode_information_response.dart';

@Injectable(as: BarcodeService)
class APIBarcodeService implements BarcodeService {
  DioClient client;

  APIBarcodeService(this.client);

  @override
  Future<Either<RequestError, BarcodeInformationResponse>> getInformation(
      String barCode) {
    // TODO: implement getInformation
    throw UnimplementedError();
  }
}
