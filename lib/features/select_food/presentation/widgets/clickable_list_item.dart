import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ClickableListItem extends StatelessWidget {
  final String title;
  final String description;

  const ClickableListItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            // fillColor: MaterialStateProperty.resolveWith(Colors.red),
            value: false,
            onChanged: _onChanged,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: AppColors.greyLabel,
                      ),
                ),
              ],
            ),
          ),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          )
        ],
      ),
    );
  }

  void _onChanged(bool? value) {}
}
