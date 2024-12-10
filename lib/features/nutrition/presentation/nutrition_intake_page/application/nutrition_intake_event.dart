part of 'nutrition_intake_bloc.dart';

@freezed
class NutritionIntakeEvent with _$NutritionIntakeEvent {
  const factory NutritionIntakeEvent.fetchProgress({required DateTime date}) = FetchProgress;
  const factory NutritionIntakeEvent.closeDay({required bool isDayClosed}) = CloseDay;
}
