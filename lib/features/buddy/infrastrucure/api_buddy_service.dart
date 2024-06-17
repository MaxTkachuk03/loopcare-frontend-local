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
  Future<Either<RequestError, Buddy>> getBuddy() async {
    return await client.get('/buddy/preferences', fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> removeBuddy() async {
    return await client.delete('/buddy/preferences', fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> inviteBuddy(RequestBuddy data) async {
    return await client.post('/buddy/preferences', data: data, fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> updateBuddy(RequestBuddy data) async {
    return await client.patch('/buddy/preferences', data: data, fromJson: Buddy.fromJson);
  }

  @override
  Future<Either<RequestError, Buddy>> resendBuddy() async {
    return await client.post('/buddy/resend', fromJson: Buddy.fromJson);
  }
}
