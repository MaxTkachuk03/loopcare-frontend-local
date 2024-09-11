import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/domain/item_action_type.dart';

part 'river_module_item_actions.freezed.dart';
part 'river_module_item_actions.g.dart';

@freezed
class RiverModuleItemActions with _$RiverModuleItemActions {
  const RiverModuleItemActions._();

  const factory RiverModuleItemActions({
    @Default(0) int id,
    int? times,
    int? identifier,
    @Default(ItemActionType.required) ItemActionType actionType,
    String? module,
    String? event,
  }) = _RiverModuleItemActions;

  factory RiverModuleItemActions.fromJson(Map<String, dynamic> json) =>
      _$RiverModuleItemActionsFromJson(json);
}
