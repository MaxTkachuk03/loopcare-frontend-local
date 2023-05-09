import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

class SearchResultListItem extends StatelessWidget {
  final SearchItem item;
  final Function(SearchItem item) onTap;

  const SearchResultListItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(item),
        child: Ink(
          color: AppColors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 15),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                item.type.icon,
                                color: AppColors.blueMid,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(width: 12.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                  color: AppColors.yellowLight, height: 1, thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
