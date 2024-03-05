part of 'buddy_bloc.dart';

@freezed
class BuddyEvent with _$BuddyEvent {
  const factory BuddyEvent.init() = InitBuddy;
  const factory BuddyEvent.nextQuestion() = BuddyNextQuestion;
  const factory BuddyEvent.previousQuestion() = BuddyPreviuosQuestion;
  const factory BuddyEvent.liveTogether({required bool liveTogether}) = BuddyLiveTogether;
  const factory BuddyEvent.relation({required String relation}) = BuddyRelation;
  const factory BuddyEvent.email({required String email}) = BuddyEmail;
}
