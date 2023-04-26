import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/education_card_type.dart';

part 'education_item.freezed.dart';

part 'education_item.g.dart';

@freezed
abstract class EducationItem implements _$EducationItem {
  const EducationItem._();

  const factory EducationItem({
    required String title,
    required String duration,
    required String label,
    required EducationCardType type,
  }) = _EducationItem;

  factory EducationItem.fromJson(Map<String, dynamic> json) =>
      _$EducationItemFromJson(json);
}
