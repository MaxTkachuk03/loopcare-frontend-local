import 'package:freezed_annotation/freezed_annotation.dart';

part 'logged_category_item.freezed.dart';

part 'logged_category_item.g.dart';

@freezed
abstract class LoggedCategoryItem implements _$LoggedCategoryItem {
  const LoggedCategoryItem._();

  const factory LoggedCategoryItem({
    required String label,
    required bool isFilled,
  }) = _LoggedCategoryItem;

  factory LoggedCategoryItem.fromJson(Map<String, dynamic> json) =>
      _$LoggedCategoryItemFromJson(json);
}
