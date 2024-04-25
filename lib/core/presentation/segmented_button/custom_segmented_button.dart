import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const Duration _animationDuration = Duration(milliseconds: 150);

class CustomSegmentedButton<T> extends StatefulWidget {
  const CustomSegmentedButton({
    super.key,
    required this.values,
    required this.itemBuilder,
    this.initialValue,
    this.itemHeight = 55,
    this.onChanged,
    this.borderColor = AppColors.blueDarker,
    this.separatorColor = AppColors.blueLighter,
    this.selectedColor = AppColors.greenRegular,
  });

  final Color borderColor;
  final Color selectedColor;
  final Color separatorColor;
  final T? initialValue;
  final double itemHeight;
  final List<T> values;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(T value)? onChanged;

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState<T> extends State<CustomSegmentedButton> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  double get sizeDelta => widget.itemHeight * 0.05;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final borderWidth = (constraints.maxWidth - 2 * sizeDelta);
        final itemHeight = widget.itemHeight;
        final itemWidth = (constraints.maxWidth - 2 * sizeDelta) / widget.values.length;

        final selectedItemHeight = itemHeight + 2 * sizeDelta;

        return Center(
          child: SizedBox(
            width: constraints.maxWidth,
            height: selectedItemHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: borderWidth,
                  height: widget.itemHeight,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.fromBorderSide(
                      BorderSide(color: widget.borderColor, width: 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      widget.values.length - 1,
                      (index) => VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: widget.separatorColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.values.length, (index) {
                    final T item = widget.values[index];

                    return InkWell(
                      onTap: () => _onChange(item),
                      borderRadius: _getBorderRadius(item),
                      child: AnimatedContainer(
                        duration: _animationDuration,
                        height: item == _value ? itemHeight + 8 : itemHeight,
                        width: item == _value ? itemWidth + 4 : itemWidth, //_calculateWidth(item, itemWidth),
                        // padding: _calculatePadding(item),
                        decoration: BoxDecoration(
                          color: item == _value ? widget.selectedColor : Colors.transparent,
                          borderRadius: _getBorderRadius(item),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: _calculateMargin(item),
                          child: widget.itemBuilder(context, index),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onChange(T value) {
    setState(() {
      _value = value;
    });

    widget.onChanged?.call(value);
  }

  EdgeInsets _calculateMargin(T value) {
    if (_value == null || value == _value) {
      return EdgeInsets.zero;
    }

    final isFirst = widget.values.first == value;
    final isLast = widget.values.last == value;

    final currentIndex = widget.values.indexOf(value);
    final selectedIndex = widget.values.indexOf(_value);

    if (isFirst || currentIndex < selectedIndex) {
      return EdgeInsets.only(left: 2 * sizeDelta);
    } else if (isLast || currentIndex > selectedIndex) {
      return EdgeInsets.only(right: 2 * sizeDelta);
    } else {
      return EdgeInsets.zero;
    }
  }

  BorderRadius _getBorderRadius(T value) => value == _value
      ? const BorderRadius.all(Radius.circular(12))
      : const BorderRadius.all(Radius.circular(0));
}
