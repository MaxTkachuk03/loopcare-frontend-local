part of 'river_bloc.dart';

@freezed
class RiverEvent with _$RiverEvent {
  const factory RiverEvent.getModules() = GetModules;

  const factory RiverEvent.getModuleById({required int moduleId}) = GetModuleById;

  const factory RiverEvent.updateModuleItem({required int moduleId, required int moduleItemId}) =
      UpdateModuleItem;

  const factory RiverEvent.updateModule({required int moduleId}) = UpdateModule;

  const factory RiverEvent.checkCompletion() = CheckCompletion;

  const factory RiverEvent.completeActiveModule() = CompleteActiveModule;
}
