import 'package:freezed_annotation/freezed_annotation.dart';

part 'dialog_filter.freezed.dart';

part 'dialog_filter.g.dart';

@freezed
abstract class DialogFilter implements _$DialogFilter {
  const DialogFilter._();

  const factory DialogFilter({
    required String name,
    required bool selected,
  }) = _DialogFilter;

  factory DialogFilter.fromJson(Map<String, dynamic> json) =>
      _$DialogFilterFromJson(json);
}
