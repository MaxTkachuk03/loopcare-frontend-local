part of 'group_chat_bloc.dart';

@freezed
class GroupChatState with _$GroupChatState {
  const factory GroupChatState.initial(GroupChatStateData data) = _Initial;

  const factory GroupChatState.sentSuccess(GroupChatStateData data) = _SentSuccess;

  const factory GroupChatState.uploadSuccess(GroupChatStateData data) = _UploadSuccess;

  const factory GroupChatState.uploadedMembers(GroupChatStateData data) = _UploadedMembers;

  const factory GroupChatState.messageRemoved(GroupChatStateData data) = _MessageRemoved;

  const factory GroupChatState.loading(GroupChatStateData data) = _Loading;

  const factory GroupChatState.error(GroupChatStateData data) = _Error;
}

@freezed
class GroupChatStateData with _$GroupChatStateData {
  const GroupChatStateData._();

  const factory GroupChatStateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMembers,
    @Default([]) List<GroupMessage> messages,
    @Default([]) List<GroupMember> members,
    @Default(false) bool hasReachedMessagesMax,
    @Default(false) bool hasReachedMembersMax,
  }) = _GroupChatStateData;
}
