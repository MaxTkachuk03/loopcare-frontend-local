import 'package:bubble/bubble.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/infrastructure/services/overlay_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/overlay_service_mode.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_controller.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return Bubble(
      color: _getBgColor(),
      borderColor: _getBgColor(),
      margin: widget.nextMessageInGroup ? const BubbleEdges.symmetric(horizontal: 6) : null,
      nipOffset: 4,
      style: const BubbleStyle(padding: BubbleEdges.fromLTRB(0.0, 0.0, 8.0, 8.0)),
      nip: widget.nextMessageInGroup
          ? BubbleNip.no
          : widget.controller.user.id != widget.message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
      child: InkWell(
        onTap: () => serviceLocator.get<OverlayService>().show(
              OverlayEvent.chatPopCard(
                context: context,
                mode: OverlayServiceMode.chat(
                  canRemove: widget.controller.user.id == widget.message.author.id,
                  onCopy: () => _copy(context, widget.message.text),
                  onReport: () => _onPressHandler(context),
                  onRemove: () => widget.controller.removedMessage(fromMessageId: widget.message.id),
                ),
              ),
            ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.child,
              Align(
                alignment: Alignment.centerRight,
                child: CustomText.w400(
                  getFormattedDateFromMilliseconds(widget.message.createdAt),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.blueDarker,
                    fontSize: ThemeConstants.fontSize10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBgColor() =>
      widget.controller.user.id != widget.message.author.id || widget.message.type == types.MessageType.image
          ? AppColors.white
          : AppColors.orangeOffRegular;

  void _onPressHandler(BuildContext context) {
    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    ModalBottomSheet.reportAbuse(context: context);
  }

  void _copy(BuildContext context, String message) {
    Clipboard.setData(ClipboardData(text: message)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.blueDarker,
          content: CustomText.w400(
            LocalizedTexts.snackMassageCopy.tr(),
            textAlign: TextAlign.left,
            style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ),
      );
    });
  }
}
