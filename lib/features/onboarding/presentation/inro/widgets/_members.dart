part of '../onboarding_intro_our_mission_page.dart';

enum _Member {
  andrew,
  maria,
  shalu,
  joshua,
  denise;

  Color get color => switch(this) {
    andrew => AppColors.greenRegular,
    maria => AppColors.petrolRegular,
    shalu => AppColors.coralRegular,
    joshua => AppColors.yellowRegular,
    denise => AppColors.orangeRegular,
  };

  ImageProvider get image => switch(this) {
    andrew => AppImages.onboardingIntro4,
    maria => AppImages.onboardingIntro5,
    shalu => AppImages.onboardingIntro2,
    joshua => AppImages.onboardingIntro3,
    denise => AppImages.onboardingIntro1,
  };

  Offset get position => switch(this) {
    andrew => const Offset(0.6, 0.55),
    maria => const Offset(0.04, 0.42),
    shalu => const Offset(0.36, 0.32),
    joshua => const Offset(0.13, 0.08),
    denise => const Offset(0.65, 0.16),
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
    maria => const Offset(0.44, 0.66),
    shalu => const Offset(0.57, 0.72),
    joshua => const Offset(0.45, 0.01),
    denise => const Offset(0.7, 0.04),
  };

  double get arrowRotation => switch(this) {
    andrew => -1.32,
    maria => 1.57,
    shalu => 2.4,
    joshua => 0.3,
    denise => 0.0,
  };

  double get mirrorArrowRotation => switch(this) {
    andrew => math.pi,
    maria => 0.0,
    shalu => 0.0,
    joshua => 0.0,
    denise => math.pi,
  };
}
