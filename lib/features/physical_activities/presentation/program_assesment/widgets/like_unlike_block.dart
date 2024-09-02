import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const _kRegularHeight = 68.0;
const _kSelectedHeight = 74.0;
const _kSelectedWidth = 64.0;
const _kRegularWidth = 66.0;
const _kBorderThick = 2.0;
const _kBorderRadius = 10.0;

class LikeUnlikeBlock extends StatefulWidget {
  final Color? selectedColor;

  final void Function(bool like) onLikeChange;

  const LikeUnlikeBlock({
    super.key,
    this.selectedColor = AppColors.yellowRegular,
    required this.onLikeChange,
  });

  @override
  State<LikeUnlikeBlock> createState() => _LikeUnlikeBlockState();
}

class _LikeUnlikeBlockState extends State<LikeUnlikeBlock> {
  int selectedThumb = 0;

  Color get borderColor => AppColors.blueDarker;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _kSelectedHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (selectedThumb == -1)
                ? _SelectedButton(
                    icon: AppIcons.noScore,
                    label: LocalizedTexts.notReally.tr(),
                    color: widget.selectedColor,
                  )
                : _RegularButton(
                    label: LocalizedTexts.notReally.tr(),
                    icon: AppIcons.noScore,
                    onTap: () => _onThumbsTap(-1),
                  ),
            if (selectedThumb == 0) _Divider(),
            (selectedThumb == 1)
                ? _SelectedButton(
                    icon: AppIcons.yesScoreFilled,
                    label: LocalizedTexts.yesYes.tr(),
                    color: widget.selectedColor,
                  )
                : _RegularButton(
                    isLeft: false,
                    label: LocalizedTexts.yesYes.tr(),
                    icon: AppIcons.yesScore,
                    onTap: () => _onThumbsTap(1),
                  ),
          ],
        ),
      ),
    );
  }

  void _onThumbsTap(int like) {
    setState(() {
      selectedThumb = like;
      widget.onLikeChange(like == 1);
    });
  }
}

class _SelectedButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color? color;

  const _SelectedButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kSelectedWidth,
      height: _kSelectedHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(_kBorderRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 8.0),
          CustomText.w700(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: ThemeConstants.fontSize12,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegularButton extends StatelessWidget {
  final Widget icon;
  final Function() onTap;
  final String label;
  final bool isLeft;

  const _RegularButton({
    required this.icon,
    required this.onTap,
    required this.label,
    this.isLeft = true,
  });

  Color get borderColor => AppColors.blueDarker;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: _kRegularWidth,
        height: _kRegularHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: isLeft
                ? const BorderRadius.only(
                    topLeft: Radius.circular(_kBorderRadius),
                    bottomLeft: Radius.circular(_kBorderRadius),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(_kBorderRadius),
                    bottomRight: Radius.circular(_kBorderRadius),
                  ),
            border: isLeft
                ? Border(
                    left: BorderSide(width: _kBorderThick, color: borderColor),
                    top: BorderSide(width: _kBorderThick, color: borderColor),
                    bottom: BorderSide(width: _kBorderThick, color: borderColor),
                  )
                : Border(
                    right: BorderSide(width: _kBorderThick, color: borderColor),
                    top: BorderSide(width: _kBorderThick, color: borderColor),
                    bottom: BorderSide(width: _kBorderThick, color: borderColor),
                  )),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 8.0),
              CustomText.w700(
                label,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: ThemeConstants.fontSize12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kRegularHeight,
      width: 1,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: _kBorderThick, color: AppColors.blueDarker),
          bottom: BorderSide(width: _kBorderThick, color: AppColors.blueDarker),
        ),
      ),
      child: const VerticalDivider(
        thickness: 1,
        color: AppColors.blueLighter,
      ),
    );
  }
}
