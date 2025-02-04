part of 'nutrition_intake_bloc.dart';

@freezed
class NutritionIntakeEvent with _$NutritionIntakeEvent {
  const factory NutritionIntakeEvent.fetchProgress({required DateTime date}) = FetchProgress;

  const factory NutritionIntakeEvent.completeDay({required String date}) = CompleteDay;

  const factory NutritionIntakeEvent.finishLesson({required String date, required int iLessonId}) =
      FinishLesson;

  const factory NutritionIntakeEvent.resetSurvey() = ResetSurvey;
}
