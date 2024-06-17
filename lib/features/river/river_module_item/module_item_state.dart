import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/river/river_module_item/river_module_item_utils.dart';

part 'module_item_state.freezed.dart';

@freezed
class ModuleItemMode with _$ModuleItemMode {
  const ModuleItemMode._();

  const factory ModuleItemMode.disable({
    required Color contentColor,
    required RiverModuleItemType contentType,
  }) = _DisableState;

  const factory ModuleItemMode.unlock({
    required Color contentColor,
    required RiverModuleItemType contentType,
  }) = _UnlockState;

  const factory ModuleItemMode.read({
    required Color contentColor,
    required RiverModuleItemType contentType,
  }) = _ReadState;

  const factory ModuleItemMode.completed({
    required Color contentColor,
    required RiverModuleItemType contentType,
  }) = _CompletedState;
}

extension ModuleItemStateExt on ModuleItemMode {
  T onMap<T extends Object>({
    required T Function() disable,
    required T Function() unlock,
    required T Function() read,
    required T Function() completed,
  }) =>
      map(
        disable: (mode) => disable.call(),
        unlock: (mode) => unlock.call(),
        read: (mode) => read.call(),
        completed: (mode) => completed.call(),
      );

  Color get bgColor => map(
        disable: (mode) => state.getBackgroundColor(mode.contentColor),
        unlock: (mode) => state.getBackgroundColor(mode.contentColor),
        read: (mode) => state.getBackgroundColor(mode.contentColor),
        completed: (mode) => state.getBackgroundColor(mode.contentColor),
      );
  Color get iconColor => map(
    disable: (mode) => state.getIconColor(mode.contentColor),
    unlock: (mode) => state.getIconColor(mode.contentColor),
    read: (mode) => state.getIconColor(mode.contentColor),
    completed: (mode) => state.getIconColor(mode.contentColor),
  );

  RiverModuleItemState get state => map(
        disable: (mode) => RiverModuleItemState.disable,
        unlock: (mode) => RiverModuleItemState.unlock,
        read: (mode) => RiverModuleItemState.read,
        completed: (mode) => RiverModuleItemState.completed,
      );

  RiverModuleItemType get contentType => map(
        disable: (mode) => mode.contentType,
        unlock: (mode) => mode.contentType,
        read: (mode) => mode.contentType,
        completed: (mode) => mode.contentType,
      );
}
