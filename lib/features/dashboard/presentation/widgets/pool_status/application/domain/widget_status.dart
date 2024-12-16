import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_status.freezed.dart';
part 'widget_status.g.dart';

@freezed
class WidgetStatus with _$WidgetStatus {
  const factory WidgetStatus({
    required String? text,
    required String? state,
  }) = _WidgetStatus;

  factory WidgetStatus.fromJson(Map<String, dynamic> json) => _$WidgetStatusFromJson(json);
}
