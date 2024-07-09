import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const _defaultContentPadding = EdgeInsets.all(8.0);
const _defaultLeadingExtend = 10.0;
const _defaultTrailingExtend = 10.0;
const _defaultElevation = 4.0;
const _defaultBorderRadius = BorderRadius.all(Radius.circular(12));

class CustomTappableCard extends StatelessWidget {
  const CustomTappableCard({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.isSelected = false,
    this.contentPadding,
    this.leadingExtend,
    this.trailingExtend,
    this.color,
    this.selectedColor,
    this.disabledColor,
    this.borderRadius,
    this.elevation,
    this.enabled = true,
    this.disable = false,
  });

  /// A widget to display before the child.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  final Widget? trailing;

  /// The card's internal padding.
  ///
  /// Insets a [CustomTappableCard]'s contents: its [leading], [child], and
  /// [trailing] widgets.
  ///
  /// If this is null, `EdgeInsets.all(8.0)` is used.
  final EdgeInsets? contentPadding;

  /// The primary content of the card.
  final Widget child;

  /// If this property is true, card rendered with the [selectedColor]
  /// and [elevation] is 0.
  ///
  /// By default is false.
  final bool isSelected;

  /// Space between [leading] and [child] widgets.
  ///
  /// If this is null, `10.0` is used.
  final double? leadingExtend;

  /// Space between [child] and [trailing] widgets.
  ///
  /// If this is null, `10.0` is used.
  final double? trailingExtend;

  /// Called when the user taps this card.
  final void Function()? onPressed;

  /// Defines the background card color.
  ///
  /// If this property is null then [ColorScheme.surface] is used.
  final Color? color;

  /// Defines the background item color if card is selected.
  ///
  /// If this property is null then [ColorScheme.primary] is used.
  final Color? selectedColor;

  /// Defines the background item color if card is disabled.
  ///
  /// If this property is null then
  /// 'Theme.of(context).disabledColor.withOpacity(0.5)' is used.
  final Color? disabledColor;

  /// The border radius of the containing rectangle.
  ///
  /// If this is null, it is interpreted as 'BorderRadius.all(Radius.circular(12))'.
  final BorderRadius? borderRadius;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material and the opacity
  /// of the elevation overlay color if it is applied.
  ///
  /// If this is non-zero, the contents of the material are clipped, because the
  /// widget conceptually defines an independent printed piece of material.
  ///
  /// Defaults to 4.
  final double? elevation;

  /// Whether this card is interactive.
  ///
  /// If false, the [onPressed] callback is inoperative.
  final bool enabled;

  /// Whether this card is interactive
  ///
  /// If false, the [onPressed] callback is inoperative, change [elevation]
  /// to 0.0 and change [color] to disabled color.
  final bool disable;

  const CustomTappableCard.greenLightest({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.isSelected = false,
    this.contentPadding,
    this.leadingExtend,
    this.trailingExtend,
    this.borderRadius,
    this.elevation,
    this.disabledColor,
    this.enabled = true,
    this.disable = false,
  })  : color = AppColors.greenLightest,
        selectedColor = AppColors.greenRegular;

  @override
  Widget build(BuildContext context) {
    final effectiveLeadingExtend = leadingExtend ?? _defaultLeadingExtend;
    final effectiveTrailingExtend = trailingExtend ?? _defaultTrailingExtend;
    final effectivePadding = contentPadding ?? _defaultContentPadding;
    final effectiveColor = color ?? Theme.of(context).colorScheme.surface;
    final effectiveSelectedColor = selectedColor ?? Theme.of(context).colorScheme.primary;
    final effectiveBorderRadius = borderRadius ?? _defaultBorderRadius;


    final elevationState = isSelected || disable ? 0.0 : (elevation ?? _defaultElevation);
    final highlightColor = isSelected ? effectiveColor.withOpacity(0.2) : effectiveSelectedColor.withOpacity(0.2);

    Color colorState;
    if (isSelected) {
      colorState = effectiveSelectedColor;
    } else if (disable) {
      colorState = disabledColor ?? Theme.of(context).disabledColor.withOpacity(0.5);
    } else {
      colorState = effectiveColor;
    }

    Widget content = child;

    if (leading != null || trailing != null) {
      content = Row(
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: effectiveLeadingExtend),
          ],
          Expanded(child: content),
          if (trailing != null) ...[
            SizedBox(width: effectiveTrailingExtend),
            trailing!,
          ],
        ],
      );
    }

    return Material(
      elevation: elevationState,
      color: colorState,
      borderRadius: effectiveBorderRadius,
      surfaceTintColor: Colors.transparent,
      child: IgnorePointer(
        ignoring: disable || !enabled,
        child: InkWell(
          onTap: onPressed,
          highlightColor: highlightColor,
          borderRadius: effectiveBorderRadius,
          child: Opacity(
            opacity: disable ? 0.5 : 1,
            child: Padding(
              padding: effectivePadding,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
