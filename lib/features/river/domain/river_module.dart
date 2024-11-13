import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_state.dart';
import 'package:ntp/ntp.dart';

part 'river_module.freezed.dart';
part 'river_module.g.dart';

@freezed
class RiverModule with _$RiverModule {
  const RiverModule._();

  const factory RiverModule({
    @Default(0) int id,
    @Default('') String title,
    @Default(0) int nextModuleUnlockDelay,
    @Default(RiverModuleState.locked) RiverModuleState moduleState,
    @Default([]) List<RiverModuleItem> moduleItems,
    DateTime? nextModuleUnlocksAt,
  }) = _RiverModule;

  factory RiverModule.fromJson(Map<String, dynamic> json) => _$RiverModuleFromJson(json);
}

extension RiverModuleExtension on RiverModule? {
  Future<bool> lookCompletion() async {
    if (this == null) return false;

    final isActiveModuleNotCompleted = this?.moduleState.isInProgress ?? false;
    final timePassed = await isTimePassed;

    return isActiveModuleNotCompleted && timePassed && isModuleItemsCompleted;
  }

  bool get isModuleItemsCompleted =>
      this?.moduleItems.every((i) => i.states.prevItemState.isCompleted || i.isReadCrossModule) ??
      false;

  Future<bool> get isTimePassed async {
    final now = await NTP.now();
    return this?.nextModuleUnlocksAt?.isBefore(now) ?? false;
  }

  bool get containCompletedCrossModuleItem =>
      this?.moduleItems.any((i) => i.isCompletedCrossModule) ?? false;

  bool get containReadCrossModuleItem => this?.moduleItems.any((i) => i.isReadCrossModule) ?? false;

  bool get containCrossModuleItem => this?.moduleItems.any((i) => i.crossModule) ?? false;

  bool get isLocked => this == null || this?.moduleState == RiverModuleState.locked;

  bool get isInProgress => this?.moduleState == RiverModuleState.inProgress;

  bool get isCompleted => this?.moduleState == RiverModuleState.completed;
}
