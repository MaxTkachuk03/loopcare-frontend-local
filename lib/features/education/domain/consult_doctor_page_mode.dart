import 'package:freezed_annotation/freezed_annotation.dart';

part 'consult_doctor_page_mode.freezed.dart';

@freezed
class ConsultDoctorPageMode with _$ConsultDoctorPageMode {
  const factory ConsultDoctorPageMode.afterLesson() = AfterLesson;

  const factory ConsultDoctorPageMode.userProfile() = UserProfile;
}
