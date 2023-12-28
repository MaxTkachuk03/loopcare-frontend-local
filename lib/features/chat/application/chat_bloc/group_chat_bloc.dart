import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/chat/application/chat_service.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';

part 'group_chat_bloc.freezed.dart';
part 'group_chat_event.dart';
part 'group_chat_state.dart';

@singleton
class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final ChatService _chatService;
  final AuthenticationCubit authBloc;

  GroupChatBloc(this._chatService, this.authBloc) : super(const GroupChatState.initial(GroupChatStateData())) {
    on<ChatEventInit>(_onInitReportAbuse);
    on<SendMessage>(_onSendMessage);
    on<GetMessages>(_onGetMessages);
    on<GetMembers>(_onGetMembers);
    on<RemoveMessages>(_onRemoveMessages);
  }

  FutureOr<void> _onInitReportAbuse(
    ChatEventInit event,
    Emitter<GroupChatState> emit,
  ) async =>
      emit(const GroupChatState.initial(GroupChatStateData()));

  FutureOr<void> _onGetMembers(
    GetMembers event,
    Emitter<GroupChatState> emit,
  ) async {
    if (!_hasReachedMembersMax || (event.refresh ?? false)) {
      emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: true)));
      final response =
          await _chatService.getMembers(id: (event.refresh ?? false) ? null : _fromMemberId, limit: _limit);
      response.fold(
        (error) {
          debugPrint('devcpp Error Members : ${error.toString()}.');
          emit(GroupChatState.error(GroupChatStateData(error: error, isLoadingMembers: false)));
        },
        (r) {
          final List<GroupMember> result = (event.refresh ?? false) ? r.data : [..._currentMembers, ...r.data];
          emit(
            GroupChatState.uploadedMembers(
              state.data.copyWith(
                hasReachedMembersMax: r.data.isEmpty || r.data.length < _limit,
                members: result,
              ),
            ),
          );
          emit(GroupChatState.loading(state.data.copyWith(isLoadingMembers: false)));
        },
      );
    }
  }

  FutureOr<void> _onRemoveMessages(
    RemoveMessages event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
    final response = await _chatService.removeMessage(fromMessageId: event.fromMessageId);
    response.fold(
      (error) {
        emit(GroupChatState.error(GroupChatStateData(error: error, isLoading: false)));
      },
      (response) {
        List<GroupMessage> list = List<GroupMessage>.from(_currentMessages);
        list.removeWhere((element) => '${element.id}' == event.fromMessageId);
        list.add(response);
        list.sort((a, b) {
          return b.createdAt!.compareTo(a.createdAt!);
        });
        emit(
          GroupChatState.messageRemoved(
            state.data.copyWith(
              isLoading: false,
              messages: list,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onSendMessage(
    SendMessage event,
    Emitter<GroupChatState> emit,
  ) async {
    emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
    final response = await _chatService.sendMessages(event.message);
    response.fold(
      (error) {
        emit(GroupChatState.error(GroupChatStateData(error: error, isLoading: false)));
      },
      (response) {
        emit(
          GroupChatState.sentSuccess(
            state.data.copyWith(
              isLoading: false,
              messages: [response, ..._currentMessages],
            ),
          ),
        );
        add(const GroupChatEvent.getMessages());
      },
    );
  }

  FutureOr<void> _onGetMessages(
    GetMessages event,
    Emitter<GroupChatState> emit,
  ) async {
    if (!_hasReachedMessagesMax || (event.refresh ?? false)) {
      emit(GroupChatState.loading(state.data.copyWith(isLoading: true)));
      final response = await _chatService.getMessages(
          fromMessageId: (event.refresh ?? false) ? null : _fromMessageId, limit: _limit, order: _order);
      response.fold(
        (error) {
          debugPrint('devcpp Error Messages : ${error.toString()}.');
          emit(GroupChatState.error(GroupChatStateData(error: error, isLoading: false)));
        },
        (r) {
          r.data.sort((a, b) {
            return b.createdAt!.compareTo(a.createdAt!);
          });
          for (final message in r.data) {
            debugPrint('devcpp Message: ${message.id}');
          }
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
    // convert each item to a string by using JSON encoding
    final jsonList = list.map((item) => jsonEncode(item)).toList();
    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();
    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => GroupMessage.fromJson(jsonDecode(item))).toList();
    return result;
  }

  List<GroupMessage> get _currentMessages => state.data.messages;

  List<GroupMember> get _currentMembers => state.data.members;

  String? get _fromMessageId => _currentMessages.isNotEmpty ? '${_currentMessages.last.id}' : null;

  int? get _fromMemberId => _currentMembers.isNotEmpty ? _currentMembers.last.accountId : null;

  bool get _hasReachedMessagesMax => state.data.hasReachedMessagesMax;

  bool get _hasReachedMembersMax => state.data.hasReachedMembersMax;

  int get _limit => 20;

  String get _order => 'DESC';
}
