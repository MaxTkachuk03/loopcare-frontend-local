import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

part 'river_module.freezed.dart';

part 'river_module.g.dart';

@freezed
class RiverModule with _$RiverModule {
  const RiverModule._();

  const factory RiverModule({
    @Default(0) int id,
    @Default('') String title,
    @Default(0) int nextModuleUnlockDelay,
    @Default(false) bool isCompleted,
    @Default([]) List<RiverModuleItem> moduleItems,
    DateTime? nextModuleUnlocksAt,
  }) = _RiverModule;

  factory RiverModule.fromJson(Map<String, dynamic> json) => _$RiverModuleFromJson(json);
}
