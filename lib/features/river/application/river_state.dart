part of 'river_bloc.dart';

@freezed
class RiverState with _$RiverState {
  const factory RiverState.initial(RiverStateData data) = RiverStateInitial;

  const factory RiverState.moduleLoading(RiverStateData data) = RiverStateModuleLoading;

  const factory RiverState.moduleLoadingError(RiverStateData data) = RiverStateModuleLoadingError;

  const factory RiverState.moduleLoaded(RiverStateData data) = RiverStateModuleLoaded;

  const factory RiverState.moduleItemLoading(RiverStateData data) = RiverStateModuleItemLoading;

  const factory RiverState.moduleItemLoadingError(RiverStateData data) =
      RiverStateModuleItemLoadingError;

  const factory RiverState.moduleItemLoaded(RiverStateData data) = RiverStateModuleItemLoaded;

  const factory RiverState.moduleItemSelected(RiverStateData data) = RiverStateModuleItemSelected;
}

@freezed
class RiverStateData with _$RiverStateData {
  const RiverStateData._();

  const factory RiverStateData({
    @Default([]) List<RiverModule> modules,
    @Default(false) bool isLoading,
    RiverModule? activeModule,
    RiverModuleItem? activeModuleItem,
    RequestError? error,
  }) = _RiverStateData;

  int get currentPage => activeModule != null ? modules.indexOf(activeModule!) : 0;

  bool get isBeginningComplete => modules.isEmpty
      ? true
      : modules.indexOf(modules.firstWhere(
        (m) => !m.isCompleted,
        orElse: () => modules.last,
      )) > 0;

  bool get isBeginningStarted =>
      currentPage == 0 && (activeModule?.moduleItems.any((item) => item.isCompleted) ?? true);

  bool get isProfileCompleted =>
      modules.firstOrNull?.moduleItems
          .firstWhereOrNull((item) => item.isProfile)?.isCompleted ?? true;

  bool get isPracticeCompleted =>
      modules.firstOrNull?.moduleItems
          .firstWhereOrNull((item) => item.isPractice)?.isCompleted ?? true;
}
