part of 'river_bloc.dart';

@freezed
class RiverEvent with _$RiverEvent {
  const factory RiverEvent.getModules() = GetModules;

  const factory RiverEvent.getActualModule() = GetActualModule;

  const factory RiverEvent.updateModuleItem({required int moduleId, required int moduleItemId}) =
      UpdateModuleItem;

  const factory RiverEvent.checkCompletion() = CheckCompletion;

  const factory RiverEvent.completeActiveModule() = CompleteActiveModule;

  const factory RiverEvent.selectModuleItem({RiverModuleItem? item}) = SelectModuleItem;
}
