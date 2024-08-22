import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_service.dart';
import 'package:loopcare_frontend/features/chat/application/chat_service.dart';
import 'package:loopcare_frontend/features/chat/application/chat_watcher_bloc/chat_watcher_bloc.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';

part 'group_chat_bloc.freezed.dart';
part 'group_chat_event.dart';
part 'group_chat_state.dart';

@singleton
class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final ChatService chatService;
  final ChatWatcherBloc _chatWatcherBloc;
  final AppSyncService _syncService;

  GroupChatBloc(
    this.chatService,
    this._chatWatcherBloc,
    this._syncService,
  ) : super(const GroupChatState.initial(GroupChatStateData())) {
    on<ChatEventInit>(_onInitReportAbuse);
    on<SendMessage>(_onSendMessage);
    on<GetMessages>(_onGetMessages);
    on<GetMembers>(_onGetMembers);
    on<RemoveMessages>(_onRemoveMessages);
    on<RemoveMessageFromSocket>(_onRemoveMessageFromSocket);
    on<NewMessage>(_onNewMessage);
    on<SetReadPointer>(_onSetReadPointer);
    on<GetUnreadCount>(_onGetUnreadCount);

    _syncService.stream.listen(
     (event) {
       event.whenOrNull(
         refreshChatMessages: () {
           add(const GroupChatEvent.getUnreadCount());
           add(const GroupChatEvent.getMessages(refresh: true));
         },
       );
     },
    );
  }

  FutureOr<void> _onInitReportAbuse(
    ChatEventInit event,
    Emitter<GroupChatState> emit,
  ) async =>
      emit(const GroupChatState.initial(GroupChatStateData()));

  FutureOr<void> _onGetUnreadCount(
    GetUnreadCount event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: false)));
    final response = await chatService.unreadCount();
    response.fold(
      (e) => emit(GroupChatState.error(GroupChatStateData(error: e, isLoadingMembers: false))),
      (r) {
        _chatWatcherBloc.add(ChatWatcherEvent.getNewMassage(r.data));
        emit(GroupChatState.gotUnreadCount(
          state.data.copyWith(isLoadingMembers: false, counter: r.data),
        ));
      },
    );
  }

  FutureOr<void> _onSetReadPointer(
    SetReadPointer event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: false)));
    final response = await chatService.readPointer(fromMessageId: event.fromMessageId);
    response.fold(
      (error) => emit(GroupChatState.error(GroupChatStateData(error: error, isLoadingMembers: false))),
      (r) {
        add(const GroupChatEvent.getUnreadCount());
        emit(GroupChatState.pointedSuccess(state.data.copyWith(isLoadingMembers: false)));
      },
    );
  }

  FutureOr<void> _onNewMessage(
    NewMessage event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(
      GroupChatState.loading(
        state.data.copyWith(isLoadingMembers: false),
      ),
    );
    List<GroupMessage> list = List<GroupMessage>.from([..._currentMessages, event.message]);
    list.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
    emit(
      GroupChatState.gotMessageFromSocket(
        state.data.copyWith(isLoading: false, messages: list),
      ),
    );
  }

  FutureOr<void> _onGetMembers(
    GetMembers event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: true)));
    final response = await chatService.getMembers();
    response.fold(
      (error) => emit(
        GroupChatState.error(
          GroupChatStateData(error: error, isLoadingMembers: false),
        ),
      ),
      (r) {
        final list = List<GroupMember>.from(r.data);
        list.sort((a, b) {
          return a.nickname!.toLowerCase().compareTo(b.nickname!.toLowerCase());
        });
        emit(
          GroupChatState.uploadedMembers(
            state.data.copyWith(
              members: list,
            ),
          ),
        );
        emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: false)));
      },
    );
  }

  FutureOr<void> _onRemoveMessageFromSocket(
    RemoveMessageFromSocket event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
    final removable = _currentMessages.firstWhereOrNull((e) => e.id == event.fromMessageId);
    if (removable != null) {
      List<GroupMessage> list = List<GroupMessage>.from(_currentMessages);
      list.removeWhere((element) => '${element.id}' == event.fromMessageId);
      final removedMessage = GroupMessage(
        updatedAt: removable.updatedAt,
        createdAt: removable.createdAt,
        id: removable.id,
        accountId: removable.accountId,
        text: '',
        isDeleted: true,
        replyMessageId: null,
      );
      list.add(removedMessage);
      list.sort((a, b) {
        return b.createdAt!.compareTo(a.createdAt!);
      });
      emit(
        GroupChatState.messageRemoved(
          state.data.copyWith(isLoading: false, messages: list),
        ),
      );
    } else {
      GroupChatState.messageRemoved(
        state.data.copyWith(isLoading: false),
      );
    }
  }

  FutureOr<void> _onRemoveMessages(
    RemoveMessages event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
    final response = await chatService.removeMessage(fromMessageId: event.fromMessageId);
    response.fold(
      (error) => emit(
        GroupChatState.error(
          GroupChatStateData(error: error, isLoading: false),
        ),
      ),
      (response) => emit(
        GroupChatState.messageRemoved(
          state.data.copyWith(
            isLoading: false,
            // messages: list
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSendMessage(
    SendMessage event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(
      GroupChatState.loading(
        state.data.copyWith(isLoading: true),
      ),
    );
    final response = await chatService.sendMessages(event.message);
    response.fold(
      (error) {
        emit(
          GroupChatState.error(
            GroupChatStateData(error: error, isLoading: false),
          ),
        );
      },
      (response) {
        emit(
          GroupChatState.sentSuccess(
            state.data.copyWith(
              isLoading: false,
              messages: _currentMessages,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetMessages(
    GetMessages event,
    Emitter<GroupChatState> emit,
  ) async {
    if (!_hasReachedMessagesMax || (event.refresh ?? false)) {
      emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
      final response = await chatService.getMessages(
          fromMessageId: (event.refresh ?? false) ? null : _fromMessageId, limit: _limit, order: _order);
      response.fold(
        (error) {
          emit(GroupChatState.error(GroupChatStateData(error: error, isLoading: false)));
        },
        (r) {
          r.data.sort((a, b) {
            return b.createdAt!.compareTo(a.createdAt!);
          });
          final List<GroupMessage> result = (event.refresh ?? false) ? r.data : [..._currentMessages, ...r.data];
          final uniqueData = unique(result);
          emit(
            GroupChatState.uploadSuccess(
              state.data.copyWith(
                hasReachedMessagesMax: !r.meta.hasNext || r.data.isEmpty || r.data.length < _limit,
                messages: uniqueData,
              ),
            ),
          );
          emit(GroupChatState.loading(state.data.copyWith(isLoading: false)));
        },
      );
    }
  }

  List<GroupMessage> unique(List<GroupMessage> list) {
    final jsonList = list.map((item) => jsonEncode(item)).toList();
    final uniqueJsonList = jsonList.toSet().toList();
    final result = uniqueJsonList.map((item) => GroupMessage.fromJson(jsonDecode(item))).toList();
    return result;
  }

  List<GroupMessage> get _currentMessages => state.data.messages;

  String? get _fromMessageId => _currentMessages.isNotEmpty ? '${_currentMessages.last.id}' : null;

  bool get _hasReachedMessagesMax => state.data.hasReachedMessagesMax;

  int get _limit => 20;

  String get _order => 'DESC';
}
