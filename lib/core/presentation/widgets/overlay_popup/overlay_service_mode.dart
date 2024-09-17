import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/sheet_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'overlay_service_mode.freezed.dart';

@freezed
class OverlayServiceMode with _$OverlayServiceMode {
  const OverlayServiceMode._();

  const factory OverlayServiceMode.chat({
    required bool canRemove,
    required void Function() onRemove,
    required void Function() onCopy,
    required void Function() onReport,
  }) = ChatMode;
}

enum ServiceActionsType {
  removeGroupMessage,
  reportGroupMessage,
  copy,
}

class ServiceActionsList {
  const ServiceActionsList._();

  static List<ServiceActionsType> chatActions({required bool canRemove}) => [
        ServiceActionsType.reportGroupMessage,
        ServiceActionsType.copy,
        if (canRemove) ServiceActionsType.removeGroupMessage,
      ];
}

extension ServiceActionsTypeUtils on ServiceActionsType {
  String get title {
    switch (this) {
      case ServiceActionsType.copy:
        return LocalizedTexts.copyGroupMessage.tr();
      case ServiceActionsType.removeGroupMessage:
        return LocalizedTexts.removeGroupMessage.tr();
      case ServiceActionsType.reportGroupMessage:
        return LocalizedTexts.reportGroupMessage.tr();
    }
  }

  SvgPicture get icon {
    switch (this) {
      case ServiceActionsType.removeGroupMessage:
        return AppIcons.remove;
      case ServiceActionsType.copy:
        return AppIcons.copy;
      case ServiceActionsType.reportGroupMessage:
        return AppIcons.report;
    }
  }

  T? mapOrNull<T extends Object?>({
    T Function()? onCopy,
    T Function()? onReport,
    T Function()? onRemove,
  }) {
    switch (this) {
      case ServiceActionsType.reportGroupMessage:
        return onReport?.call();
      case ServiceActionsType.removeGroupMessage:
        return onRemove?.call();
      case ServiceActionsType.copy:
        return onCopy?.call();
    }
  }
}

extension OverlayServiceModeItems on OverlayServiceMode {
  List<SheetItem> get items {
    return map(
      chat: (data) => ServiceActionsList.chatActions(
        canRemove: data.canRemove,
      )
          .map(
            (item) => SheetItem(
              title: item.title,
              icon: item.icon,
              onTap: item.mapOrNull(
                onCopy: () => data.onCopy,
                onReport: () => data.onReport,
                onRemove: () => data.onRemove,
              ),
            ),
          )
          .toList(),
    );
  }
}
