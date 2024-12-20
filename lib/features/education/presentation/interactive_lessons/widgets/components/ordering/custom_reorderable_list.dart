import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/content_ordering_item.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/ordering_content.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/ordering/reorderable_list_label.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class CustomReorderableList extends StatefulWidget {
  final InteractiveLessonChunkComponentOrdering component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  const CustomReorderableList({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  @override
  State<CustomReorderableList> createState() => _CustomReorderableListState();
}

class _CustomReorderableListState extends State<CustomReorderableList> {
  bool _showOrderValidation = false;
  bool _isNotReordered = false;

  List<ContentOrderingItem> get items => widget.component.content.items;

  OrderingContent get content => widget.component.content;

  @override
  void initState() {
    final rightOrder = content.correctOrder;

    if (widget.component.progress != null &&
        widget.component.progress!.optionIds != null) {
      _isNotReordered = true;
      items.sort((a, b) =>
          rightOrder.indexOf(a.order).compareTo(rightOrder.indexOf(b.order)));
      _showOrderValidation = true;
    }
    super.initState();
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.04, animValue)!;

        return Transform.scale(scale: scale, child: child);
      },
      child: child,
    );
  }

  RoundedRectangleBorder? getShape(bool isValid) => _showOrderValidation
      ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isValid ? AppColors.greenRegular : AppColors.coralRegular,
            width: 3,
          ),
        )
      : null;

  void _onReorderHandler(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      content.updateOrder(oldIndex, newIndex);
    });
  }

  void _onShowAnswerHandler() {
    final rightOrder = content.correctOrder;

    setState(() {
      items.sort((a, b) =>
          rightOrder.indexOf(a.order).compareTo(rightOrder.indexOf(b.order)));
      _showOrderValidation = true;
      _isNotReordered = true;
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(
            optionIds: rightOrder, type: widget.component.type.name),
        widget.component);
  }

  void _onCheckOrderHandler() {
    final order = items.map((i) => i.order).toList();
    List<int> rightOrder = content.correctOrder;

    setState(() {
      _showOrderValidation = true;
    });

    final isOrderRight = checkOrder(order, rightOrder);

    if (!isOrderRight) return;

    setState(() {
      _isNotReordered = true;
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(
            optionIds: rightOrder, type: widget.component.type.name),
        widget.component);
  }

  bool checkOrder(List<int> order, List<int> rightOrder) {
    for (int i = 0; i < order.length; i++) {
      if (order[i] != rightOrder[i]) {
        return false;
      }
    }

    return true;
  }

  void _onReorderStartHandler(_) {
    setState(() {
      _showOrderValidation = false;
    });
  }

  static const double iconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 12),
      decoration: BoxDecoration(
        color: widget.lessonStreamType.lighterColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            header: ReorderableListLabel(label: content.topLabel),
            footer: ReorderableListLabel(label: content.bottomLabel),
            onReorder:
                _isNotReordered ? (oldIndex, newIndex) {} : _onReorderHandler,
            onReorderStart: _onReorderStartHandler,
            proxyDecorator: proxyDecorator,
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              ContentOrderingItem item = entry.value;
              final bool isValid = content.correctOrder[index] == item.order;

              return Card(
                key: ValueKey(item.id),
                shape: getShape(isValid),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12)),
                      child: item.src.isNotEmpty
                          ? Image.network(
                              item.src,
                              height: iconSize,
                              width: iconSize,
                              fit: BoxFit.fill,
                            ) // Load network image if src exists
                          : const Image(
                              height: iconSize,
                              width: iconSize,
                              image: AppImages.nutrition,
                              fit: BoxFit.fill,
                            ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        CustomText.w700(item.title,
                            style: context.textTheme.bodyMedium),
                        CustomText(item.description,
                            style: context.textTheme.bodyMedium),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.drag_handle,
                        color: AppColors.greenLighter),
                    const SizedBox(width: 15.0)
                  ],
                ),
              );
            }).toList(),
          ),
          CustomElevatedButton.blueFullWidth(
            onPressed: _isNotReordered ? null : _onCheckOrderHandler,
            label: LocalizedTexts.interactiveLessonsOrderingCheck.tr(),
          ),
          const SizedBox(height: 12),
          CustomOutlinedButton.blueFullWidth(
            onPressed: _isNotReordered ? null : _onShowAnswerHandler,
            label: LocalizedTexts.interactiveLessonsOrderingShowAnswer.tr(),
          ),
        ],
      ),
    );
  }
}
