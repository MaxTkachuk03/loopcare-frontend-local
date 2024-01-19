import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';

part 'list_group_members.g.dart';

@immutable
@JsonSerializable()
class ListGroupMembers {
  final List<GroupMember> data;

  const ListGroupMembers({
    @Default([]) required this.data,
  });

  static ListGroupMembers fromJson(Map<String, dynamic> json) => _$ListGroupMembersFromJson(json);

  Map<String, dynamic> toJson() => _$ListGroupMembersToJson(this);
}
