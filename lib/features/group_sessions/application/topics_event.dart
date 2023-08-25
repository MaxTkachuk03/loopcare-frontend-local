part of 'topics_bloc.dart';

@freezed
class TopicsEvent with _$TopicsEvent {
  const factory TopicsEvent.fetchTopics() = FetchTopics;

  const factory TopicsEvent.signUpToSession() = SignUpToSession;

  const factory TopicsEvent.signOutFromSession() = SignOutFromSession;
}
