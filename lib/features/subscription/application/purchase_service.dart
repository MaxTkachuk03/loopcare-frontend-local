import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data.dart';

abstract class PurchaseService {
  Future<Either<RequestError, Subscription>> verifyPurchase(VerifyPurchaseData receipt, String vendor);
}