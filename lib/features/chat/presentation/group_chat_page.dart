import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:loopcare_frontend/core/infrastructure/services/overlay_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/input_decoration.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/overlay_service_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/group_chat_report.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_controller.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/bubble_widget.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/group_chat_user_avatar.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/hexagon_avatar.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key});

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> with WidgetsBindingObserver {
  late GroupChatController controller;
  final _maxMessageLength = 1024;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    types.User user = _getUser();
    controller = GroupChatController(bloc: context.read<GroupChatBloc>(), user: user)
      ..refreshMessages()
      ..refreshMembers();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      types.User user = _getUser();
      controller = GroupChatController(bloc: context.read<GroupChatBloc>(), user: user)
        ..refreshMessages()
        ..refreshMembers();
    }
  }

  DefaultChatTheme get chatTheme => DefaultChatTheme(
        messageInsetsHorizontal: 10,
        messageInsetsVertical: 4,
        receivedMessageBodyTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.blueDarkest,
          fontSize: 12.0,
        ),
        sentMessageBodyTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.blueDarkest,
          fontSize: 12.0,
        ),

        // messageBorderRadius: 16,
        seenIcon: CustomText.w400(
          'read',
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.blueDarker,
            fontSize: ThemeConstants.fontSize10,
          ),
        ),
        inputTextColor: AppColors.blueDarker,
        inputBackgroundColor: AppColors.orangeRegular,
        backgroundColor: AppColors.orangeLightest,
        inputBorderRadius: BorderRadius.zero,
        inputTextStyle: appThemeData.textTheme.bodyMedium!.copyWith(color: AppColors.blueDarker),
        inputTextDecoration: AppInputDecoration(
            context: context,
            radius: 10.0,
            focusedColor: AppColors.orangeLightest,
            enableBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.orangeLightest),
            )),
        inputPadding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
        dateDividerTextStyle: appThemeData.textTheme.bodyMedium!.copyWith(
          color: AppColors.blueDarker,
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w600,
        ),
        sendButtonIcon: CircleAvatar(
          backgroundColor: AppColors.blueRegular,
          radius: 20,
          child: AppIcons.send,
        ),
      );

  types.User _getUser() {
    final id = context.read<AuthenticationCubit>().state.id;
    types.User user = types.User(
      id: '$id',
    );
    return user;
  }

  int get _getGroupId => context.read<AuthenticationCubit>().state.groupId!;

  @override
  Widget build(BuildContext context) {
    return KeyboardContainerListener(
      child: BlocConsumer<GroupChatBloc, GroupChatState>(
        listener: _onChangeListener,
        builder: (BuildContext context, GroupChatState state) {
          return CustomScaffold.orangeLightest(
            appBar: CustomAppBar.orange(
              title: LocalizedTexts.groupChat.tr(),
              subtitle: controller.getNames(state),
              onTap: () => context.router.push(GroupUsersRoute(controller: controller)),
              leading: const SizedBox.shrink(),
              actions: const [SizedBox(width: 30)],
            ),
            body: Chat(
              messages: controller.getMessages(state.data.messages, state.data.members),
              bubbleBuilder: _bubbleBuilder,
              avatarBuilder: (user) => GroupChatUserAvatar(author: user),
              onSendPressed: (message) {
                return message.text.length > _maxMessageLength ? _showPopover() : controller.handleSendPressed(message);
              },
              onMessageLongPress: (BuildContext context, dynamic message) => serviceLocator.get<OverlayService>().show(
                    OverlayEvent.chatPopCard(
                      context: context,
                      needOffset: controller.user.id == message.author.id,
                      mode: OverlayServiceMode.chat(
                        canRemove: controller.user.id == message.author.id,
                        onCopy: () => _copy(context, message.text),
                        onReport: () => _onPressHandler(
                            context,
                            GroupChatReport(
                              accountId: int.parse(message.author.id),
                              groupId: _getGroupId,
                              messageId: int.parse(message.id),
                              text: message.text,
                            )),
                        onRemove: () => controller.removedMessage(fromMessageId: message.id),
                      ),
                    ),
                  ),
              onEndReached: !state.data.isLoading ? controller.handleEndReached : null,
              showUserAvatars: true,
              showUserNames: true,
              user: controller.user,
              customDateHeaderText: (date) => date.isToday ? LocalizedTexts.today.translation : date.dayWithMonth,
              theme: chatTheme,
            ),
          );
        },
      ),
    );
  }

  void _showPopover() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: CustomText('${LocalizedTexts.messageLengthRestriction.tr()}.'),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: Text(LocalizedTexts.ok.toUpperCase()),
            ),
          ],
        ),
      );

  void _onPressHandler(BuildContext context, GroupChatReport groupChatReport) {
    context.read<ReportAbuseBloc>().add(const ReportAbuseEvent.init());
    ModalBottomSheet.reportAbuse(context: context, chatReport: groupChatReport);
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

  void _onChangeListener(BuildContext context, GroupChatState state) {
    state.maybeMap(
      uploadSuccess: (_) => _setReadPointer(state),
      gotMessageFromSocket: (_) => _setReadPointer(state),
      orElse: () => {},
      error: _onErrorHandler,
    );
  }

  void _setReadPointer(GroupChatState state) {
    if (state.data.messages.isNotEmpty &&
        context.tabsRouter.activeIndex == 2 &&
        context.read<AuthenticationCubit>().state.isUserGrouped) {
      controller.setReadPointer(fromMessageId: state.data.messages.first.id!);
    }
  }

  void _onErrorHandler(GroupChatState state) {
    final String? errorMessage = state.data.error?.maybeMap(
      unprocessableEntity: (s) => s.error.message,
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
    );
    context.showErrorBar(
      content: CustomText(errorMessage ?? ''),
      position: FlashPosition.top,
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) =>
      message.text.isEmpty
          ? Container(
              height: avatarSize,
              alignment: controller.user.id != message.author.id ? Alignment.centerLeft : Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomText.w400(
                LocalizedTexts.messageRemoved.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: ThemeConstants.fontSize12,
                ),
              ),
            )
          : BubbleWidget(
              message: message,
              nextMessageInGroup: nextMessageInGroup,
              controller: controller,
              child: child,
            );
}
