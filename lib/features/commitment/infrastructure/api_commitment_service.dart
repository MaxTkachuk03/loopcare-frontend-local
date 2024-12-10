import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

import 'package:loopcare_frontend/features/commitment/application/dto/get_commitment_response.dart';
import 'package:loopcare_frontend/features/commitment/domain/commitment_service.dart';

// TODO use mock
import 'package:loopcare_frontend/features/commitment/infrastructure/commitment_mock.dart';

@Injectable(as: CommitmentService)
class APICommitmentService implements CommitmentService {
  DioClient client;

  APICommitmentService(this.client);

  @override
  Future<Either<RequestError, GetCommitmentResponse>> getCommitment(
      {required DateTime startDate, required DateTime endDate}) async {
    // TODO use to mock
    return right(GetCommitmentResponse.fromJson(commitmentJson));

    // return await client.get(
    //   '/commitment',
    //   queryParameters: {"startDate": startDate, "endDate": endDate},
    //   fromJson: GetGoalsResponse.fromJson,
    // );
  }
}
