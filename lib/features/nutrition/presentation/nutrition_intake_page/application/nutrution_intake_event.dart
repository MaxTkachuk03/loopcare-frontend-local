part of 'nutrution_intake_bloc.dart';

@freezed
class NutrutionIntakeEvent with _$NutrutionIntakeEvent {
  const factory NutrutionIntakeEvent.fetchProgress({required DateTime date}) = FetchProgress;
    const factory NutrutionIntakeEvent.closeDay({required bool isDayClosed}) = CloseDay;
}