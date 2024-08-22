import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_animation_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';

part 'river_module_item_view_state.freezed.dart';
part 'river_module_item_view_state.g.dart';

@freezed
class RiverModuleItemViewState with _$RiverModuleItemViewState {
  const RiverModuleItemViewState._();

  const factory RiverModuleItemViewState({
    @Default(RiverModuleItemState.locked) RiverModuleItemState itemState,
    @Default(RiverModuleItemState.locked) RiverModuleItemState prevItemState,
    @Default(RiverModuleItemAnimationState.no)  RiverModuleItemAnimationState animationState,
  }) = _RiverModuleItemViewState;

  factory RiverModuleItemViewState.unlock() => const RiverModuleItemViewState(
    itemState: RiverModuleItemState.unlocked,
    prevItemState: RiverModuleItemState.locked,
    animationState: RiverModuleItemAnimationState.unlock,
  );

  factory RiverModuleItemViewState.fromJson(Map<String, dynamic> json) =>
      _$RiverModuleItemViewStateFromJson(json);
}

class RiverModuleItemViewStateConverter implements JsonConverter<RiverModuleItemViewState, Map<String, dynamic>> {
  const RiverModuleItemViewStateConverter();

  @override
  RiverModuleItemViewState fromJson(Map<String, dynamic> json) {
    final itemState = RiverModuleItemState.values.byName(json['itemState']);
    final rawPrevItemState = json['prevItemState'];
    final prevItemState = _stateFromRaw(rawPrevItemState, itemState);

    return RiverModuleItemViewState(
      itemState: itemState,
      prevItemState: prevItemState,
      animationState: _getAnimatedState(itemState, prevItemState),
    );
  }

  RiverModuleItemState _stateFromRaw(String? rawPrevItemState, RiverModuleItemState state) {
    if (rawPrevItemState != null) {
     return RiverModuleItemState.values.byName(rawPrevItemState);
    } else if (state.isReadOrHigher) {
      return state;
    } else {
      return RiverModuleItemState.locked;
    }
  }

  RiverModuleItemAnimationState _getAnimatedState(
    RiverModuleItemState itemState,
    RiverModuleItemState prevItemState,
  ) {
    if (itemState.isUnLockedOrHigher && prevItemState.isLocked) {
      return RiverModuleItemAnimationState.unlock;
    } else if (itemState.isReadOrHigher && prevItemState.isUnLocked) {
      return RiverModuleItemAnimationState.read;
    } else if (itemState.isCompleted && prevItemState.isRead) {
      return RiverModuleItemAnimationState.complete;
    } else if (itemState.isRead && prevItemState.isCompleted) {
      return RiverModuleItemAnimationState.reversCompletion;
    } else if (itemState.isUnLocked && prevItemState.isUnLocked) {
      return RiverModuleItemAnimationState.idling;
    } else {
      return RiverModuleItemAnimationState.no;
    }
  }

  @override
  Map<String, dynamic> toJson(RiverModuleItemViewState data) => data.toJson();
}
