// Flutter imports:
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/popup_card.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/sheet_item.dart';

mixin AppOverlays {
  static Future onShowPopoverCard(
    BuildContext context,
    RelativeRect position,
    Widget content,
  ) =>
      showCard(
        context: context,
        position: position,
        content: content,
      );

  static Future onShowMenuPopup(
    BuildContext context,
    RelativeRect position,
    List<PopupMenuEntry<SheetItem>> items,
  ) =>
      showMenu(
        context: context,
        position: position,
        items: items,
        color: AppColors.blueDarker,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      );
}
