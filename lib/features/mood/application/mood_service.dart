import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mood/application/dto/get_moods_response.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';

abstract class MoodService {
  Future<Either<RequestError, GetMoodsResponse>> getMoods({
    required String startDate,
    required String endDate,
  });

  Future<Either<RequestError, Mood>> createMood(Mood data);

  Future<Either<RequestError, Mood>> updateMood(int id, Mood data);

  Future<Either<RequestError, Mood>> deleteMood(int id);
}
