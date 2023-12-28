import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
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
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_controller.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/bubble_widget.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/group_chat_user_avatar.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key});

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> with WidgetsBindingObserver {
  late GroupChatController controller;

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
    controller = GroupChatController(bloc: context.read<GroupChatBloc>())
      ..refreshMessages()
      ..refreshMembers();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      controller = GroupChatController(bloc: context.read<GroupChatBloc>())
        ..refreshMessages()
        ..refreshMembers();
    }
  }

  DefaultChatTheme get chatTheme => DefaultChatTheme(
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
            focusedColor: AppColors.orangeLightest,
            enableBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.orangeLightest),
            )),
        dateDividerTextStyle: appThemeData.textTheme.bodyMedium!.copyWith(
          color: AppColors.blueDarker,
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w500,
        ),
        sendButtonIcon: CircleAvatar(
          backgroundColor: AppColors.blueRegular,
          radius: 20,
          child: AppIcons.send,
        ),
      );

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
              onSendPressed: controller.handleSendPressed,
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

  void _onChangeListener(BuildContext context, GroupChatState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
    );
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
          ? CustomText.w400(
              LocalizedTexts.massageRemoved.tr(),
              style: context.textTheme.bodySmall,
            )
          : BubbleWidget(
              message: message,
              nextMessageInGroup: nextMessageInGroup,
              controller: controller,
              child: child,
            );
}
