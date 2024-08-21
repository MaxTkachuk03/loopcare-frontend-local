import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/buddy/domain/request_buddy.dart';
import 'package:loopcare_frontend/features/buddy/infrastrucure/buddy_service.dart';

@Injectable(as: BuddyService)
class APIBuddyService implements BuddyService {
  DioClient client;

  APIBuddyService(this.client);

  @override
  Future<Either<RequestError, Buddy>> getBuddy() {
    return client.get('/buddy/preferences', fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> removeBuddy() {
    return client.delete('/buddy/preferences', fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> inviteBuddy(RequestBuddy data) {
    return client.post('/buddy/preferences', data: data, fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> updateBuddy(RequestBuddy data) {
    return client.patch('/buddy/preferences', data: data, fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> rejectInvitation() {
    return client.post('/buddy/reject-invitation', fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> resendBuddy() {
    return client.post('/buddy/resend', fromJson: Buddy.fromJson);
  }
}
