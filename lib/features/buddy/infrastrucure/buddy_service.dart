import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/buddy/domain/request_buddy.dart';

abstract class BuddyService {
  Future<Either<RequestError, Buddy>> getBuddy();
  Future<Either<RequestError, Buddy>> removeBuddy();
  Future<Either<RequestError, Buddy>> updateBuddy(RequestBuddy data);
  Future<Either<RequestError, Buddy>> inviteBuddy(RequestBuddy data);
  Future<Either<RequestError, Buddy>> rejectInvitation();
  Future<Either<RequestError, Buddy>> resendBuddy();
}
