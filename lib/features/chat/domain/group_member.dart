import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_member.g.dart';

@immutable
@JsonSerializable()
class GroupMember {
  final int? accountId;
  final String? nickname;

  const GroupMember({
    this.accountId,
    this.nickname,
  });

  static GroupMember fromJson(Map<String, dynamic> json) => _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}
