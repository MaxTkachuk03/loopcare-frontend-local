import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_label.freezed.dart';

part 'name_label.g.dart';

@freezed
abstract class NameLabel implements _$NameLabel {
  const NameLabel._();

  const factory NameLabel({
    required String name,
    required String label,
  }) = _NameLabel;

  factory NameLabel.fromJson(Map<String, dynamic> json) =>
      _$NameLabelFromJson(json);
}
