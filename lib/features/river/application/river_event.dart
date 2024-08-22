part of 'river_bloc.dart';

@freezed
class RiverEvent with _$RiverEvent {
  const factory RiverEvent.init() = InitRiver;

  const factory RiverEvent.getModules() = GetModules;

  const factory RiverEvent.getActualModule({
    @Default(true) bool removeActiveItem,
  }) = GetActualModule;

  const factory RiverEvent.checkCompletion() = CheckCompletion;

  const factory RiverEvent.completeActiveModule() = CompleteActiveModule;

  const factory RiverEvent.updateActiveModuleItemStatus() = UpdateActiveModuleItemStatus;

  const factory RiverEvent.updateModuleItemById({
    required int moduleId,
    required int moduleItemId,
  }) = UpdateModuleItem;

  const factory RiverEvent.selectModuleItem({
    int? moduleId,
    RiverModuleItem? item,
  }) = SelectModuleItem;

  const factory RiverEvent.bounceParentItem({
    required int moduleId,
    required int moduleItemId,
  }) = BounceParentItem;
}
