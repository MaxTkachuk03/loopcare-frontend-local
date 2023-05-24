import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/get_lessons_response.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';

@Injectable(as: EducationService)
class APIEducationService implements EducationService {
  DioClient client;

  APIEducationService(this.client);

  @override
  Future<Either<RequestError, GetLessonsResponse>> getLessons(
    LessonCategory category,
  ) async {
    return process(() => Future.delayed(Duration(seconds: 0), () {
      final json = {
        'lessons': [
          {
            'id': 1,
            'category': 'general',
            'title': 'Setting expectations for a healthier lifestyle',
            'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
            'duration': '3m 59s',
            'pageCounter': 2,
            'step': 1,
            'completedAt': null,
          },
          {
            'id': 2,
            'category': 'general',
            'title': 'Understandingweight loss',
            'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
            'duration': '3m 59s',
            'pageCounter': 2,
            'step': 1,
            'completedAt': null,
          },
          {
            'id': 2,
            'category': 'general',
            'title': 'Understandingweight loss',
            'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
            'duration': '3m 59s',
            'pageCounter': 2,
            'step': 1,
            'completedAt': null,
          },
          {
            'id': 3,
            'category': 'general',
            'title': 'The importance of the buddy system',
            'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
            'duration': '3m 59s',
            'pageCounter': 2,
            'step': 2,
            'completedAt': null,
          },
        ]
      };
      final model = GetLessonsResponse.fromJson(json);
      return model;
    }));

    // return client
    //     .get('/education/lessons?$category')
    //     .then((r) => r);
  }
}
