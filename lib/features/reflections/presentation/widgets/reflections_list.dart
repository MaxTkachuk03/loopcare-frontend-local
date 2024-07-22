import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflection_list_item.dart';

class ReflectionsList extends StatelessWidget {
  final List<Reflection> list;
  final String title;
  final bool fromDashboard;
  final bool isPast;

  const ReflectionsList({
    super.key,
    required this.list,
    required this.title,
    required this.fromDashboard,
    this.isPast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(
          title,
          style: context.textTheme.bodyLarge,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int i) {
            final item = list[i];
            return ReflectionListItem(item: item, fromDashboard: fromDashboard, isPast: isPast);
          },
        ),
      ],
    );
  }
}
