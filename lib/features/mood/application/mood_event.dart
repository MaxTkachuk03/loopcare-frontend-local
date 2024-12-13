part of 'mood_bloc.dart';

@freezed
class MoodEvent with _$MoodEvent {
  const factory MoodEvent.getMoods(String startDate, String endDate) = GetMoods;

  const factory MoodEvent.deleteMood({required int moodId, required String date}) = DeleteMood;

  const factory MoodEvent.updateMood({required int moodId, required Mood data}) = UpdateMood;

  const factory MoodEvent.createMood(Mood data) = CreateMood;

  const factory MoodEvent.setDate(DateTime date) = SetDate;
}
