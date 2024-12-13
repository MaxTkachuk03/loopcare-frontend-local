import 'dart:async';

import 'package:customer_io/customer_io.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/domain/extensions/list_extensions.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/mood/application/mood_service.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'mood_bloc.freezed.dart';
part 'mood_event.dart';
part 'mood_state.dart';

@singleton
class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodService _moodService;

  MoodBloc(this._moodService)
      : super(const MoodState.initial(MoodStateData())) {
    on<GetMoods>(_onGetMoods);
    on<DeleteMood>(_onDeleteMood);
    on<UpdateMood>(_onUpdateMood);
    on<CreateMood>(_onCreateMood);
    on<SetDate>(_onSetDate);
  }

  FutureOr<void> _onGetMoods(GetMoods event, Emitter<MoodState> emit) async {
    emit(MoodState.loading(state.data.copyWith(isLoading: true)));

    final response = await _moodService.getMoods(
        startDate: event.startDate, endDate: event.endDate);

    response.fold(
      (l) => emit(
          MoodState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(MoodState.updated(state.data.copyWith(
          moods: _combineMoodsByDate(null, r.data), isLoading: false))),
    );
  }

  FutureOr<void> _onDeleteMood(
      DeleteMood event, Emitter<MoodState> emit) async {
    emit(MoodState.loading(state.data.copyWith(isLoading: true)));

    final response = await _moodService.deleteMood(event.moodId);

    response.fold(
      (l) => emit(
          MoodState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        final currentDayRecords = state.data.moods[event.date];
        currentDayRecords?.removeWhere((e) => e.id == event.moodId);
        emit(MoodState.updated(state.data.copyWith(isLoading: false)));
      },
    );
  }

  FutureOr<void> _onUpdateMood(
      UpdateMood event, Emitter<MoodState> emit) async {
    emit(MoodState.loading(state.data.copyWith(isLoading: true)));

    final response = await _moodService.updateMood(event.moodId, event.data);

    response.fold(
      (l) => emit(
          MoodState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(MoodState.updated(
          state.data.copyWith(moods: _updateMoodRecord(r), isLoading: false))),
    );
  }

  FutureOr<void> _onCreateMood(
      CreateMood event, Emitter<MoodState> emit) async {
    emit(MoodState.loading(state.data.copyWith(isLoading: true)));

    final response = await _moodService.createMood(event.data);

    response.fold(
        (l) => emit(
            MoodState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) {
      CustomerIO.track(
        name: UsageAnalyticsEvents.moodLogged,
        attributes: {
          UsageAnalyticsAttributes.emotion: event.data.emotion,
          UsageAnalyticsAttributes.companion: event.data.person,
          UsageAnalyticsAttributes.place: event.data.location,
          UsageAnalyticsAttributes.food: event.data.food,
          UsageAnalyticsAttributes.note: event.data.note,
        },
      );
      emit(MoodState.updated(state.data.copyWith(
          moods: _combineMoodsByDate(state.data.moods, [r]),
          isLoading: false)));
    });
  }

  FutureOr<void> _onSetDate(
    SetDate event,
    Emitter<MoodState> emit,
  ) async {
    final moods = state.data.moods;

    if (event.date.isAfter(DateTime.now().toLocal())) return;

    final isoStringDate = event.date.toLocal().isoStringWithoutTime;

    final bool isAlreadyLoaded = moods.containsKey(isoStringDate.split('T')[0]);

    if (isAlreadyLoaded) return;

    emit(MoodState.loading(state.data.copyWith(isLoading: true)));

    final response = await _moodService.getMoods(
      startDate: event.date.beginDay.toIso8601String(),
      endDate: event.date.endDay.toIso8601String(),
    );

    response.fold(
      (l) => emit(
          MoodState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        MoodState.updated(state.data.copyWith(
            isLoading: false,
            error: null,
            moods: _combineMoodsByDate(moods, r.data))),
      ),
    );
  }

  Map<String, List<Mood>> _combineMoodsByDate(
      Map<String, List<Mood>>? previousWeightsData, List<Mood> data) {
    Map<String, List<Mood>> moods =
        Map<String, List<Mood>>.from(previousWeightsData ?? {});

    for (Mood element in data) {
      final key = element.loggingDate.toLocal().isoStringWithoutTime;

      moods[key] != null ? moods[key]?.add(element) : moods[key] = [element];
    }

    return moods;
  }

  Map<String, List<Mood>> _updateMoodRecord(Mood newRecord) {
    Map<String, List<Mood>> moods =
        Map<String, List<Mood>>.from(state.data.moods);
    final mapKeyToUpdate = newRecord.loggingDate.toLocal().isoStringWithoutTime;

    moods.update(mapKeyToUpdate, (values) {
      final int index = values.indexWhere((el) => el.id == newRecord.id);

      return values.update(index, newRecord);
    });

    return moods;
  }
}
