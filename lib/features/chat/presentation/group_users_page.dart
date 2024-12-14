import 'package:auto_route/annotations.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_list/app_list.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_controller.dart';
import 'package:loopcare_frontend/features/chat/presentation/widget/group_member_holder.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class GroupUsersPage extends StatefulWidget {
  final GroupChatController controller;

  const GroupUsersPage({super.key, required this.controller});

  @override
  State<GroupUsersPage> createState() => _GroupUsersPageState();
}

class _GroupUsersPageState extends State<GroupUsersPage> with WidgetsBindingObserver {
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
    widget.controller.refreshMembers();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      widget.controller.refreshMembers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardContainerListener(
      child: BlocConsumer<GroupChatBloc, GroupChatState>(
        listener: _onChangeListener,
        builder: (BuildContext context, GroupChatState state) {
          return CustomScaffold.orangeLightest(
            appBar: CustomAppBar.orange(
                title: LocalizedTexts.groupChat.tr(),
                subtitle: _getNames(state),
                leading: CustomFilledIconButton.leadingOrangeLighter(),
                actions: const [
                  SizedBox(width: 30),
                ]),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 37, bottom: 20),
                  child: CustomText.bitter600(
                    LocalizedTexts.groupChatTitle.tr(),
                    style: context.textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomText.w400(
                    '${LocalizedTexts.groupChatLabel.tr(
                      {'users': '${state.data.members.length}'},
                    )}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 13),
                Expanded(
                  child: AppList<GroupMember>(
                    items: state.data.members,
                    holderText: LocalizedTexts.membersEmpty.tr(),
                    itemBuilder: (context, item) => GroupMemberHolder(
                      member: item,
                      isNotYou: int.parse(widget.controller.user.id) != item.accountId,
                    ),
                    onRefresh: () => widget.controller.refreshMembers(),
                    onLoadMore: () => widget.controller.loadMembers(),
                    isLoading: state.data.isLoadingMembers,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getNames(GroupChatState state) =>
      state.data.members.map((item) => item.nickname).toList().join(", ");

  void _onChangeListener(BuildContext context, GroupChatState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
    );
  }

  void _onErrorHandler(GroupChatState state) {
    final errorMessage = state.data.error?.maybeMap(
      unprocessableEntity: (s) => s.message,
      orElse: () => LocalizedTexts.errorSomethingWentWrong,
    );

    context.showErrorBar(
      content: CustomText(errorMessage?.tr() ?? LocalizedTexts.errorSomethingWentWrong.tr()),
      position: FlashPosition.top,
    );
  }
}
