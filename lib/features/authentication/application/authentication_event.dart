part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.init() = AuthenticationInit;

  const factory AuthenticationEvent.login({
    required String email,
    required String password,
  }) = Login;

  const factory AuthenticationEvent.logout() = Logout;

  const factory AuthenticationEvent.signUp({
    required String password,
    required RegistrationPhysicalFitnessData registrationPhysicalFitnessData,
    required MentalHealthTestAnswer mentalHealthTest,
    required MedicalOnboarding medicalOnboarding,
  }) = SignUp;

  const factory AuthenticationEvent.resendEmail() = ResendEmail;

  const factory AuthenticationEvent.forgotPassword(String email) = ForgotPassword;

  const factory AuthenticationEvent.previousStep() = PreviousStep;

  const factory AuthenticationEvent.updateName(String name) = UpdateName;

  const factory AuthenticationEvent.updateEmail({
    required String email,
    required bool receiveAnEmails,
    required bool update,
  }) = UpdateEmail;

  const factory AuthenticationEvent.startTrackUser() = StartTrackUser;

  const factory AuthenticationEvent.getAccount() = GetAccount;

  const factory AuthenticationEvent.deleteAccount() = DeleteAccount;

  const factory AuthenticationEvent.connectSockets() = ConnectSockets;

  const factory AuthenticationEvent.changeAccountGroupStatus(UserGroupingState groupingState) =
      ChangeAccountGroupStatus;

  const factory AuthenticationEvent.unlockFeature(UnlockFeature feature) = UnlockedFeature;

  const factory AuthenticationEvent.syncChatState() = SyncChatState;

  const factory AuthenticationEvent.authenticatedCheck() = AuthenticatedCheck;
}
