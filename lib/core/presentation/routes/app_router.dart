import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/auth_guard.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/email_address_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/forgot_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/login_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/name/name_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/password/password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/waiting_for_confirmation/waiting_for_confirmation_page.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/cardiovascular_disease/presentation/cardiovascular_disease_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/cardiovascular_disease_failed/presentation/cardiovascular_disease_failed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/consent_needed/consent_needed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_check_passed/presentation/medical_check_passed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_intro/medical_intro_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pain_in_chest/presentation/pain_in_chest_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pain_in_chest_failled/presentation/pain_in_chest_failled_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pregnancy_failed/presentation/pregnancy_failed.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pregnancy/pregnancy_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/stomach_reduction/stomach_reduction_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/stomach_reduction_failed/presentation/stomach_reduction_failed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/treatment_by_doctor/presentation/treatment_by_doctor_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/treatment_by_doctor_failled/presentation/treatment_by_doctor_failled_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/biological_gender/biological_gender_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/birthday_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_failed_age/check_failed_age.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/height_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_check_result/presentation/physical_check_result_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/sex/sex_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/weight_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/welcome/sign_up_welcome_page.dart';

part 'app_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      path: AppRoutes.intro,
      page: IntroPage,
    ),
    AutoRoute(
      path: AppRoutes.joinUs,
      page: JoinUsPage,
    ),
    AutoRoute(
      path: AppRoutes.height,
      page: HeightPage,
    ),
    AutoRoute(
      path: AppRoutes.weight,
      page: WeightPage,
    ),
    AutoRoute(
      path: AppRoutes.birthday,
      page: BirthdayPage,
    ),
    AutoRoute(
      path: AppRoutes.sex,
      page: SexPage,
    ),
    AutoRoute(
      path: AppRoutes.biologicalGender,
      page: BiologicalGenderPage,
    ),
    AutoRoute(
      path: AppRoutes.medicalIntro,
      page: MedicalIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.pregnancy,
      page: PregnancyPage,
    ),
    AutoRoute(
      path: AppRoutes.pregnancyFailed,
      page: PregnancyFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.cardiovascularDisease,
      page: CardiovascularDiseasePage,
    ),
    AutoRoute(
      path: AppRoutes.cardiovascularDiseaseFailed,
      page: CardiovascularDiseaseFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.stomachReduction,
      page: StomachReductionPage,
    ),
    AutoRoute(
      path: AppRoutes.stomachReductionFailed,
      page: StomachReductionFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.medicalCheckPassed,
      page: MedicalCheckPassedPage,
    ),
    AutoRoute(
      path: AppRoutes.painInChest,
      page: PainInChestPage,
    ),
    AutoRoute(
      path: AppRoutes.painInChestFailed,
      page: PainInChestFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.treatmentByDoctor,
      page: TreatmentByDoctorPage,
    ),
    AutoRoute(
      path: AppRoutes.treatmentByDoctorFailed,
      page: TreatmentByDoctorFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
      guards: [AuthGuard],
    ),
    AutoRoute(
      path: AppRoutes.physicalCheckResult,
      page: PhysicalCheckResultPage,
    ),
    AutoRoute(
      path: AppRoutes.consentNeeded,
      page: ConsentNeededPage,
    ),
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ),
    AutoRoute(
      path: AppRoutes.forgotPassword,
      page: ForgotPasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.resetPassword,
      page: ResetPasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.signUpWelcome,
      page: SignUpWelcomePage,
    ),
    AutoRoute(
      path: AppRoutes.name,
      page: NamePage,
    ),
    AutoRoute(
      path: AppRoutes.password,
      page: PasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.emailAddress,
      page: EmailAddressPage,
    ),
    AutoRoute(
      path: AppRoutes.waitingForConfirmation,
      page: WaitingForConfirmationPage,
    ),
    AutoRoute(
      path: AppRoutes.checkFailedByAge,
      page: CheckFailedAgePage,
    ),
  ],
)
class $AppRouter {}
