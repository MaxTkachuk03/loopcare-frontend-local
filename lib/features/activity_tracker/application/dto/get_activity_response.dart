import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_activity_response.g.dart';

@immutable
@JsonSerializable()
class GetActivityResponse {
  final String? loggingDate;
  final int? steps;
  final int? heartRate;
  final SleepTime? sleepTime;

  const GetActivityResponse({
    required this.loggingDate,
    required this.steps,
    this.heartRate,
    this.sleepTime,
  });

  factory GetActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetActivityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetActivityResponseToJson(this);
}

@immutable
@JsonSerializable()
class SleepTime {
  final int? hours;
  final int? minutes;

  const SleepTime({
    required this.hours,
    required this.minutes,
  });

  factory SleepTime.fromJson(Map<String, dynamic> json) => _$SleepTimeFromJson(json);

  Map<String, dynamic> toJson() => _$SleepTimeToJson(this);
}

@immutable
@JsonSerializable()
class ActivityResponse {
  final List<GetActivityResponse>? data;

  const ActivityResponse({this.data});

  factory ActivityResponse.fromJson(Map<String, dynamic> json) => _$ActivityResponseFromJson(json);
}
