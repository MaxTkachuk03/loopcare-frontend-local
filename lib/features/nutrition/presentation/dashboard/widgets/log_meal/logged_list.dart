import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/logged_list_item.dart';

class LoggedList extends StatelessWidget {
  final List<String> categoryList;
  final List<String> filledList;

  const LoggedList({
    super.key,
    required this.categoryList,
    required this.filledList,
  });

  @override
  Widget build(BuildContext context) {
    return categoryList.isEmpty
        ? const SizedBox()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return LoggedListItem(
                label: categoryList[index],
                isFilled:
                    filledList.contains(categoryList[index].toLowerCase()),
              );
            },
          );
  }
}
