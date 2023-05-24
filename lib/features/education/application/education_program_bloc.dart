import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/education_lesson.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';

part 'education_program_bloc.freezed.dart';

part 'education_program_event.dart';

part 'education_program_state.dart';

@singleton
class EducationProgramBloc
    extends Bloc<EducationProgramEvent, EducationProgramState> {
  final EducationService _educationService;

  EducationProgramBloc(this._educationService)
      : super(const EducationProgramState.initial(EducationProgramData())) {
    on<_GetLessons>(_onGetLessons);
  }

  Future<void> _onGetLessons(
    _GetLessons event,
    Emitter<EducationProgramState> emit,
  ) async {
    final response = await _educationService.getLessons(event.category);
    response.fold(
      (l) => l,
      (r) {
        emit(
          EducationProgramState.educationProgram(
            state.data.copyWith(
              lessons: r.lessons,
            ),
          ),
        );
      },
    );
  }
}
