import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mood/application/dto/get_moods_response.dart';
import 'package:loopcare_frontend/features/mood/application/mood_service.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';

@Injectable(as: MoodService)
class APIMoodService implements MoodService {
  DioClient client;

  APIMoodService(this.client);

  @override
  Future<Either<RequestError, GetMoodsResponse>> getMoods({
    required String startDate,
    required String endDate,
  }) {
    return client.get('/moods', queryParameters: {"startDate": startDate, "endDate": endDate}).then(
        parseResponse(GetMoodsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, Mood>> createMood(Mood data) {
    return client.post('/moods', data: data).then(parseResponse(Mood.fromJson));
  }

  @override
  Future<Either<RequestError, Mood>> deleteMood(int id) {
    return client.delete('/moods/$id').then(parseResponse(Mood.fromJson));
  }

  @override
  Future<Either<RequestError, Mood>> updateMood(int id, Mood data) {
    return client.patch('/moods/$id', data: data).then(parseResponse(Mood.fromJson));
  }
}
