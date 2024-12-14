import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_action_page_mode.freezed.dart';

@freezed
class ExtraActionPageMode with _$ExtraActionPageMode {
  const factory ExtraActionPageMode.afterLesson() = AfterLesson;

  const factory ExtraActionPageMode.userProfile() = UserProfile;
}
