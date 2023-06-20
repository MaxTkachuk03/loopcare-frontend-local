import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/logged_list_item.dart';

class LoggedList extends StatelessWidget {
  final List<String> categoryList;
  final List<String> categoryListRaw;
  final List<String> filledList;

  const LoggedList({
    super.key,
    required this.categoryList,
    required this.categoryListRaw,
    required this.filledList,
  });

  @override
  Widget build(BuildContext context) {
    return categoryList.isEmpty
        ? const SizedBox()
        : Column(
            children: categoryList.map((category) {
              return LoggedListItem(
                label: category,
                isFilled: filledList.contains(category.toLowerCase()),
              );
            }).toList(),
          );
  }
}
