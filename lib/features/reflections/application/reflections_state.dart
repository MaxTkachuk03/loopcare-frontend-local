part of 'reflections_bloc.dart';

@freezed
class ReflectionsState with _$ReflectionsState {
  const factory ReflectionsState.initial(ReflectionsStateData data) =
      ReflectionsStateInitial;

  const factory ReflectionsState.loading(ReflectionsStateData data) =
      ReflectionsStateLoading;

  const factory ReflectionsState.error(ReflectionsStateData data) =
      ReflectionsStateError;

  const factory ReflectionsState.reflectionsLoaded(ReflectionsStateData data) =
      ReflectionsStateReflectionsLoaded;
}

@freezed
class ReflectionsStateData with _$ReflectionsStateData {
  const ReflectionsStateData._();

  const factory ReflectionsStateData({
    @Default([]) List<Reflection> reflections,
    @Default(null) Reflection? activeReflection,
    @Default(false) bool isLoading,
    @Default(null) RequestError? error,
  }) = _ReflectionsStateData;

  bool hasReflectionsForCurrentWeek(DateTime selectedDay) =>
      getSelectedWeekUndoneReflections(selectedDay).isNotEmpty ||
      getSelectedDayDoneReflections(selectedDay).isNotEmpty;

  List<Reflection> getSelectedWeekUndoneReflections(DateTime selectedDay) {
    return reflections.where((r) {
      final unlockedDate = r.unlockedAt;

      if (unlockedDate == null) return false;

      return unlockedDate.isBefore(selectedDay) && r.completedAt == null;
    }).toList();
  }

  List<Reflection> getSelectedDayDoneReflections(DateTime selectedDay) =>
      reflections
          .where((r) =>
              r.completedAt?.dateOnly.isSameDate(selectedDay.dateOnly) ?? false)
          .toList();

  List<Reflection> getPastReflections(DateTime selectedDay) {
    final endDate = selectedDay.subtract(7.days);

    return reflections.where((r) {
      final unlockedDate = r.unlockedAt;

      if (unlockedDate == null) return false;

      return r.isComplete || unlockedDate.isBefore(endDate);
    }).toList();
  }

  String get errorKey =>
      error?.message ?? LocalizedTexts.errorSomethingWentWrong;
}
