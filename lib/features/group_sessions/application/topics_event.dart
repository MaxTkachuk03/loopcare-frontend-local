part of 'topics_bloc.dart';

@freezed
class TopicsEvent with _$TopicsEvent {
  const factory TopicsEvent.fetchTopics() = FetchTopics;

  const factory TopicsEvent.getSessionSignature(int sessionId) = GetSessionSignature;

  const factory TopicsEvent.signUpToSession() = SignUpToSession;

  const factory TopicsEvent.signOutFromSession() = SignOutFromSession;
}
