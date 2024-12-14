import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy_invitation.freezed.dart';
part 'buddy_invitation.g.dart';

@freezed
abstract class BuddyInvitation implements _$BuddyInvitation {
  const BuddyInvitation._();

  const factory BuddyInvitation({
    required String relation,
    required bool liveTogether,
    required DateTime? invitationApprovedAt,
    required DateTime? invitationRejectedAt,
    required DateTime? invitationDate,
  }) = _BuddyInvitation;

  factory BuddyInvitation.fromJson(Map<String, dynamic> json) => _$BuddyInvitationFromJson(json);
}
