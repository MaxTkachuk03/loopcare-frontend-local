import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';
part 'states.g.dart';

@freezed
class States with _$States {
  const factory States({
    required String? itemState,
    String? prevItemState,
  }) = _States;

  factory States.fromJson(Map<String, dynamic> json) => _$StatesFromJson(json);
}
