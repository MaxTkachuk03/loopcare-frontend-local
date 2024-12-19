import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/commitment/application/dto/get_commitment_response.dart';

abstract class CommitmentService {
  Future<Either<RequestError, GetCommitmentResponse>> getCommitment({required DateTime date});
}
