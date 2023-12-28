import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/app_overlay.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/overlay_service_mode.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/sheet_item.dart';

mixin PopoverCardSheet {
  static Future<void> showCardPopup(
    BuildContext context,
    Offset offset,
    Widget body,
  ) =>
      AppOverlays.onShowPopoverCard(
        context,
        _definePosition(context, offset),
        body,
      );

  static void showMenuPopup(
    BuildContext context,
    OverlayServiceMode mode, {
    bool? withSeparator,
    bool? withIcon,
  }) =>
      AppOverlays.onShowMenuPopup(
        context,
        _defineBottomPosition(context),
        _generateOptions(
          mode,
          withSeparator: withSeparator,
        ),
      );
}

List<PopupMenuEntry<SheetItem>> _generateOptions(
  OverlayServiceMode mode, {
  bool? withSeparator = false,
  bool withIcon = true,
  BuildContext? itemContext,
}) {
  return List.generate(
    mode.items.length,
    (index) => PopupMenuItem(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      labelTextStyle: MaterialStateProperty.all(
        itemContext?.textTheme.bodySmall?.copyWith(color: AppColors.white),
      ),
      textStyle: itemContext?.textTheme.bodySmall?.copyWith(color: AppColors.white),
      onTap: () {
        mode.items[index].onTap?.call();
        if (itemContext != null) Navigator.pop(itemContext);
      },
      child: SizedBox(
        width: 179,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              textColor: AppColors.white,
              trailing: (withIcon && mode.items[index].icon != null) ? mode.items[index].icon! : null,
              title: CustomText.w400(
                mode.items[index].title,
                textAlign: TextAlign.start,
                style: itemContext?.textTheme.bodySmall
                    ?.copyWith(color: AppColors.white, fontSize: ThemeConstants.fontSize12),
              ),
            ),
            if ((withSeparator ?? false) && index < mode.items.length - 1) const PopupMenuDivider(),
          ],
        ),
      ),
    ),
  );
}

RelativeRect _defineBottomPosition(BuildContext context) {
  final RenderBox button = context.findRenderObject()! as RenderBox;
  final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
  final offsetButton = button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay);
  final offsetOverlay = button.localToGlobal(button.size.bottomLeft(Offset(offsetButton.dx, 0)), ancestor: overlay);
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      offsetButton,
      offsetOverlay,
    ),
    Offset.zero & overlay.size,
  );
  return position;
}

RelativeRect _definePosition(BuildContext context, [Offset offset = Offset.zero]) {
  final RenderBox button = context.findRenderObject()! as RenderBox;
  final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(offset, ancestor: overlay),
      button.localToGlobal(
        button.size.bottomRight(Offset.zero) + offset,
        ancestor: overlay,
      ),
    ),
    Offset.zero & overlay.size,
  );
  return position;
}
