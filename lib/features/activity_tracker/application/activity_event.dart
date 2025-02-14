part of 'activity_bloc.dart';

@freezed
class ActivityEvent with _$ActivityEvent {
  const factory ActivityEvent.init() = ActivityInit;

  const factory ActivityEvent.getActivity({required String startDate, required String endDate}) =
      GetActivity;

  const factory ActivityEvent.saveActivity(List body) = SaveActivity;
}
