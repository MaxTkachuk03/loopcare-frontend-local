import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_session_data.freezed.dart';

part 'fetch_session_data.g.dart';

@freezed
abstract class FetchSessionData implements _$FetchSessionData {
  const FetchSessionData._();

  const factory FetchSessionData({
    required String startDate,
    required String endDate,
  }) = _FetchSessionData;

  factory FetchSessionData.fromJson(Map<String, dynamic> json) => _$FetchSessionDataFromJson(json);
}
