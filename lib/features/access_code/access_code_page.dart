import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/domain/registration_code/registration_code.dart';
import 'package:url_launcher/url_launcher.dart';

class AccessCodePage extends StatefulWidget {
  const AccessCodePage({super.key});

  @override
  State<AccessCodePage> createState() => _AccessCodePageState();
}

class _AccessCodePageState extends State<AccessCodePage> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<String?> _codeErrorText = ValueNotifier(null);
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);

  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardContainerListener(
      child: CustomScaffold.green(
        appBar: CustomAppBar.transparent(
          leading: CustomFilledIconButton.leadingGreenLighter(),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Container(alignment: Alignment.center, child: const Image(image: AppImages.intro3)),
                      const SizedBox(height: 28.0),
                      CustomText.bitter600(
                        LocalizedTexts.registrationCodeTitle,
                        style: context.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      CustomText.w400(
                        LocalizedTexts.registrationCodeLabel,
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 23.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Form(
                          key: _formKey,
                          onChanged: _onChangedForm,
                          child: Column(
                            children: [
                              ValueListenableBuilder<String?>(
                                valueListenable: _codeErrorText,
                                builder: (context, errorText, _) {
                                  return CustomTextField.registrationCode(
                                    controller: _codeController,
                                    errorText: errorText,
                                    onChanged: _onCodeChanged,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                  Column(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _isDisabled,
                        builder: (context, disable, _) {
                          return CustomElevatedButton.blueFullWidth(
                            onPressed: disable ? null : () => _onRegisterPressed(context),
                            label: LocalizedTexts.checkAccessCode,
                          );
                        },
                      ),
                      const SizedBox(height: 21.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: context.textTheme.bodyMedium,
                          children: [
                            TextSpan(text: '${LocalizedTexts.noAccessCodeYet.tr()} '),
                            TextSpan(
                              text: LocalizedTexts.requestCode.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()..onTap = _launchInBrowser,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onChangedForm() => _isDisabled.value = !RegistrationCode.create(_codeController.text).isRight();

  void _onRegisterPressed(BuildContext context) {
    _codeErrorText.value = null;
    context.router.pushNamed(AppRoutes.joinUs);
  }

  Future<void> _launchInBrowser() async {
    final Uri launchUri = Uri.parse(leanOnMeWeb);
    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.translation));
    }
  }

  void _onCodeChanged(String value) {
    if (_codeErrorText.value == null) return;
    _codeErrorText.value = null;
  }
}
