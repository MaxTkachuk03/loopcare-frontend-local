import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/like_unlike_options.dart';
import 'package:loopcare_frontend/core/presentation/segmented_button/custom_segmented_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class LikeUnlikeSelector extends StatefulWidget {
  final Function(LikeUnlikeOptions val) onChange;
  final LikeUnlikeOptions? value;

  const LikeUnlikeSelector({super.key, required this.onChange, required this.value});

  @override
  State<LikeUnlikeSelector> createState() => _LikeUnlikeSelectorState();
}

class _LikeUnlikeSelectorState extends State<LikeUnlikeSelector> {
  LikeUnlikeOptions? _selectedValue;

  @override
  void initState() {
    super.initState();

    _selectedValue = widget.value;
  }

  void _onChangedHandler(value) {
    _selectedValue = value;
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 146,
      child: CustomSegmentedButton<LikeUnlikeOptions>(
        values: LikeUnlikeOptions.values,
        onChanged: _onChangedHandler,
        initialValue: _selectedValue,
        itemHeight: 67,
        itemBuilder: (context, int i) {
          final item = LikeUnlikeOptions.values[i];
          final isSelected = item == _selectedValue;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSelected ? item.iconSelected : item.icon,
              const SizedBox(height: 8.0),
              CustomText.w500(item.label,
                  style:
                      context.textTheme.bodySmall?.copyWith(fontSize: ThemeConstants.fontSize12)),
            ],
          );
        },
      ),
    );
  }
}
