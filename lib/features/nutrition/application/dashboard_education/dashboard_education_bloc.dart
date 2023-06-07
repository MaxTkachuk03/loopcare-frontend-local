import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

part 'dashboard_education_bloc.freezed.dart';

part 'dashboard_education_event.dart';

part 'dashboard_education_state.dart';

@singleton
class DashboardEducationBloc
    extends Bloc<DashboardEducationEvent, DashboardEducationState> {
  final EducationService _educationService;

  DashboardEducationBloc(this._educationService)
      : super(const DashboardEducationState.initial(DashboardEducationData())) {
    on<_GetDashboardLessons>(_onGetDashboardLessons);
  }

  Future<void> _onGetDashboardLessons(
    _GetDashboardLessons event,
    Emitter<DashboardEducationState> emit,
  ) async {
    if (!state.isVisibleOnDashboard(event.currentDate ?? DateTime.now()))
      return;

    emit(
      DashboardEducationState.loading(state.data.copyWith(
        isLoading: true,
        error: null,
      )),
    );

    final currentDate = event.currentDate?.isoStringWithoutTime ??
        DateTime.now().isoStringWithoutTime;

    final response = await _educationService.getCalendarLessons(
      startDate: currentDate,
      endDate: currentDate,
    );

    response.fold(
      (l) => emit(
        DashboardEducationState.error(
          state.data.copyWith(
            error: l,
          ),
        ),
      ),
      (r) {
        emit(
          DashboardEducationState.educationProgram(
            state.data.copyWith(
              isLoading: false,
              completedLessons: {
                ...state.data.completedLessons,
                ...{currentDate: r.lessons},
              },
              nextLesson: r.nextLesson,
            ),
          ),
        );
      },
    );
  }
}
