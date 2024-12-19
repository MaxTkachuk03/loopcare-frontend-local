import 'package:freezed_annotation/freezed_annotation.dart';
import 'states.dart';
import 'action_item.dart';
import 'widget_status.dart';

part 'module_item.freezed.dart';
part 'module_item.g.dart';

@freezed
class ModuleItem with _$ModuleItem {
  const factory ModuleItem({
    required int? lessonId,
    required bool? isRootItem,
    required List<int>? unlocksItems,
    required List<String>? unlocksFeature,
    int? unlocksReflectionId,
    int? unlocksSmartGoalCategoryId,
    required bool crossModule,
    required String? featurePlacement,
    required String? itemState,
    required States? states,
    required int? id,
    required String? streamType,
    required String? iconType,
    required List<ActionItem>? actions,
    required int? spawnedInModuleId,
    int? completedInModuleId,
    required int? gatheredFoodItems,
    required int? gatheredDishFoodItems,
    required String? lessonType,
    required WidgetStatus? widgetStatus,
  }) = _ModuleItem;

  factory ModuleItem.fromJson(Map<String, dynamic> json) => _$ModuleItemFromJson(json);
}
