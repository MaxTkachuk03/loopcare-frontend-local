import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_meal_body.freezed.dart';

part 'get_meal_body.g.dart';

@freezed
abstract class GetMealBody implements _$GetMealBody {
  const factory GetMealBody({
    required String startDate,
    required String endDate,
  }) = _GetMealBody;

  const GetMealBody._();

  factory GetMealBody.fromJson(Map<String, dynamic> json) => _$GetMealBodyFromJson(json);
}
