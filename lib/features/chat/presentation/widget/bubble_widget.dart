import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_controller.dart';

final GetIt serviceLocator = GetIt.instance;

class BubbleWidget extends StatefulWidget {
  final Widget child;
  final dynamic message;
  final dynamic nextMessageInGroup;
  final GroupChatController controller;

  const BubbleWidget({
    super.key,
    required this.message,
    required this.nextMessageInGroup,
    required this.child,
    required this.controller,
  });

  @override
  State<BubbleWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget> {
  Color get _getBgColor => AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      alignment: Alignment.centerLeft,
      color: _getBgColor,
      borderColor: _getBgColor,
      radius: const Radius.circular(10),
      margin: widget.nextMessageInGroup ? const BubbleEdges.symmetric(horizontal: 0) : null,
      nipOffset: 4,
      style: const BubbleStyle(padding: BubbleEdges.fromLTRB(0.0, 0.0, 0.0, 0.0)),
      nip: widget.nextMessageInGroup
          ? BubbleNip.no
          : widget.controller.user.id != widget.message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.child,
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: CustomText.w400(
                      getFormattedDateFromMilliseconds(widget.message.createdAt),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.blueDarker,
                        fontSize: ThemeConstants.fontSize10,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
