import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SearchListTitleItem extends StatelessWidget {
  final String text;

  const SearchListTitleItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 25,
            right: 15,
          ),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(
          color: AppColors.yellowLight,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
