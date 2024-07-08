part of '../onboarding_intro_our_mission_page.dart';

enum _Member {
  andrew,
  maria,
  shalu,
  joshua,
  denise;

  Color get color => switch(this) {
    andrew => AppColors.greenRegular,
    maria => AppColors.orangeRegular,
    shalu => AppColors.coralRegular,
    joshua => AppColors.yellowRegular,
    denise => AppColors.petrolRegular,
  };

  ImageProvider get image => switch(this) {
    andrew => AppImages.onboardingIntro4,
    maria => AppImages.onboardingIntro1,
    shalu => AppImages.onboardingIntro2,
    joshua => AppImages.onboardingIntro3,
    denise => AppImages.onboardingIntro5,
  };

  Offset get position => switch(this) {
    andrew => const Offset(0.6, 0.55),
    maria => const Offset(0.65, 0.16),
    shalu => const Offset(0.36, 0.32),
    joshua => const Offset(0.13, 0.08),
    denise => const Offset(0.04, 0.42),
  };

  String get description => switch(this) {
    andrew => LocalizedTexts.onboardingIntroMissionAndrew,
    maria => LocalizedTexts.onboardingIntroMissionMaria,
    shalu => LocalizedTexts.onboardingIntroMissionShalu,
    joshua => LocalizedTexts.onboardingIntroMissionJoshua,
    denise => LocalizedTexts.onboardingIntroMissionDenise,
  };

  Offset get arrowPosition => switch(this) {
    andrew => const Offset(0.46, 0.68),
    maria => const Offset(0.7, 0.04),
    shalu => const Offset(0.57, 0.72),
    joshua => const Offset(0.45, 0.01),
    denise => const Offset(0.44, 0.66),
  };

  double get arrowRotation => switch(this) {
    andrew => -1.32,
    maria => 0.0,
    shalu => 2.4,
    joshua => 0.3,
    denise => 1.57,
  };

  double get mirrorArrowRotation => switch(this) {
    andrew => math.pi,
    maria => math.pi,
    shalu => 0.0,
    joshua => 0.0,
    denise =>0.0,
  };
}

String get _longestMemberDescription {
  final members = _Member.values.map((e) => e.description.tr()).toList()
    ..sort((a, b) => a.length.compareTo(b.length));

  return members.last;
}
