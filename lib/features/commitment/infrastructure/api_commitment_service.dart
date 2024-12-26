import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

import 'package:loopcare_frontend/features/commitment/application/dto/get_commitment_response.dart';
import 'package:loopcare_frontend/features/commitment/domain/commitment_service.dart';

// TODO use mock
// import 'package:loopcare_frontend/features/commitment/infrastructure/commitment_mock.dart';

@Injectable(as: CommitmentService)
class APICommitmentService implements CommitmentService {
  DioClient client;

  APICommitmentService(this.client);

  @override
  Future<Either<RequestError, GetCommitmentResponse>> getCommitment(
      {required DateTime date}) async {
    // TODO use to mock
    // return right(GetCommitmentResponse.fromJson(commitmentJson));

    String convertedDate = DateFormat("yyyy-MM-dd").format(date);

    return await client.get(
      '/smart-goal/commitment',
      queryParameters: {"date": convertedDate},
      fromJson: GetCommitmentResponse.fromJson,
    );
  }
}
