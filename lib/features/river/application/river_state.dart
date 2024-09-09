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

  const factory RiverState.moduleCompleted(RiverStateData data) = RiverStateModuleCompleted;
}

@freezed
class RiverStateData with _$RiverStateData {
  const RiverStateData._();

  const factory RiverStateData({
    @Default([]) List<RiverModule> modules,
    @Default([]) List<RiverModuleItem> crossModuleItems,
    @Default(false) bool isLoading,
    RiverModule? activeModule,
    RiverModuleItem? activeModuleItem,
    RequestError? error,
  }) = _RiverStateData;

  RiverModule? get nextModule => activeModule != null && modules.last.id != activeModule?.id
      ? modules.elementAt(currentPage + 1)
      : activeModule;

  int get currentPage => activeModule != null ? modules.indexOf(activeModule!) : 0;

  bool get isBeginningComplete =>
      modules.isEmpty ||
      modules.indexOf(modules.firstWhere(
            (m) => m.moduleState.isInProgress,
            orElse: () => modules.last,
          )) >
          0;

  bool get isBeginningStarted =>
      currentPage == 0 &&
      (activeModule?.moduleItems.any((item) => item.states.prevItemState.isCompleted) ?? true);

  bool get isProfileCompleted =>
      activeModule?.moduleItems
          .firstWhereOrNull((item) => item.isProfile)
          ?.states
          .prevItemState
          .isCompleted ??
      true;

  bool get isPracticeCompleted =>
      activeModule?.moduleItems
          .firstWhereOrNull((item) => item.isPractice)
          ?.states
          .prevItemState
          .isCompleted ??
      true;
}
