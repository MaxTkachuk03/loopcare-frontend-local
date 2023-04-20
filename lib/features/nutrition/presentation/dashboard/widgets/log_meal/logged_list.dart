import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_category/logged_category_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/logged_list_item.dart';

class LoggedList extends StatelessWidget {
  final List<LoggedCategoryItem> list;

  const LoggedList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? const SizedBox()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return LoggedListItem(
                label: list[index].label,
                isFilled: list[index].isFilled,
              );
            },
          );
  }
}
