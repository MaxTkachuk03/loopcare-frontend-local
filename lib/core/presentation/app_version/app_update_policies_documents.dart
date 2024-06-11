import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class AppUpdatePoliciesDocuments extends StatefulWidget {
  const AppUpdatePoliciesDocuments({
    super.key,
    required this.updateTermsAndConditions,
    required this.updatePrivacyPolicy,
    required this.launchTermsAndConditions,
    required this.launchPrivacyPolicy,
    required this.launchEmail,
    required this.onConfirmed,
  });

  final bool updateTermsAndConditions;
  final bool updatePrivacyPolicy;
  final VoidCallback launchTermsAndConditions;
  final VoidCallback launchPrivacyPolicy;
  final VoidCallback launchEmail;
  final VoidCallback onConfirmed;

  @override
  State<AppUpdatePoliciesDocuments> createState() => _AppUpdatePoliciesDocumentsState();
}

class _AppUpdatePoliciesDocumentsState extends State<AppUpdatePoliciesDocuments> {
  final ValueNotifier<bool> validateListener = ValueNotifier(false);

  late bool termsAndConditionsAgreed;
  late bool privacyPolicyAgreed;

  void onTermsAndConditionsChanged(bool? value) {
    termsAndConditionsAgreed = value ?? termsAndConditionsAgreed;
    validate();
  }

  void onPrivacyPolicyChanged(bool? value) {
    privacyPolicyAgreed = value ?? privacyPolicyAgreed;
    validate();
  }

  void onConfirmed() {
    widget.onConfirmed();
    context.router.pop();
  }

  void validate() => validateListener.value = termsAndConditionsAgreed && privacyPolicyAgreed;

  @override
  void initState() {
    super.initState();
    termsAndConditionsAgreed = !widget.updateTermsAndConditions;
    privacyPolicyAgreed = !widget.updatePrivacyPolicy;
  }

  @override
  void dispose() {
    validateListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40.0),
          const Center(
            child: CircleAvatar(
              radius: 22.0,
              backgroundColor: AppColors.coralRegular,
              child: Icon(Icons.priority_high_rounded),
            ),
          ),
          const SizedBox(height: 20.0),
          CustomText.w600(
            LocalizedTexts.updatePoliciesDocuments.tr(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20.0),
          CustomText.w400(
            '${LocalizedTexts.updatePoliciesDocumentsBodyText1.tr()}:',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20.0),
          if (widget.updateTermsAndConditions)
            _DocumentDottedLine(
              label: LocalizedTexts.termsAndConditionsTitle.tr(),
              launch: widget.launchTermsAndConditions,
            ),
          if (widget.updatePrivacyPolicy)
            _DocumentDottedLine(
              label: LocalizedTexts.privacyPolicyTitle.tr(),
              launch: widget.launchPrivacyPolicy,
            ),
          const SizedBox(height: 20.0),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.visible,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${LocalizedTexts.updatePoliciesDocumentsBodyText2.tr()} ',
                  style: context.textTheme.bodyMedium,
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = widget.launchEmail,
                  text: supportEmailUrl,
                  style: context.textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          if (widget.updateTermsAndConditions)
            _AgreedDocumentCheckBox(
              errorText: '${LocalizedTexts.pleaseAcceptTOC.tr()}.',
              documentName: LocalizedTexts.termsAndConditions.tr(),
              launch: widget.launchTermsAndConditions,
              onChanged: onTermsAndConditionsChanged,
            ),
          if (widget.updatePrivacyPolicy && widget.updateTermsAndConditions)
            const SizedBox(height: 10),
          if (widget.updatePrivacyPolicy)
            _AgreedDocumentCheckBox(
              errorText: '${LocalizedTexts.pleaseAcceptPrivacyPolicy.tr()}.',
              documentName: LocalizedTexts.privacyPolicy.tr(),
              launch: widget.launchPrivacyPolicy,
              onChanged: onPrivacyPolicyChanged,
            ),
          const SizedBox(height: 30.0),
          ValueListenableBuilder<bool>(
            valueListenable: validateListener,
            builder: (context, isValid, _) {
              return CustomElevatedButton.blueFullWidth(
                label: LocalizedTexts.continueBtn.tr(),
                onPressed: isValid ? onConfirmed : null,
              );
            }
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

class _DocumentDottedLine extends StatelessWidget {
  const _DocumentDottedLine({
    required this.label,
    required this.launch,
  });

  final String label;
  final VoidCallback launch;

  @override
  Widget build(BuildContext context) {
    return  RichText(
      maxLines: 1,
      overflow: TextOverflow.visible,
      text: TextSpan(
        children: [
          TextSpan(
            text: '  • ',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = launch,
            text: label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}


class _AgreedDocumentCheckBox extends StatelessWidget {
  const _AgreedDocumentCheckBox({
    required this.documentName,
    required this.errorText,
    required this.launch,
    required this.onChanged,
  });

  final String documentName;
  final String errorText;
  final VoidCallback launch;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxFormField(
      errorText: errorText,
      text: RichText(
        maxLines: 2,
        overflow: TextOverflow.visible,
        text: TextSpan(
          text: '${LocalizedTexts.iAcceptThe.tr()} ',
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = launch,
              text: documentName,
              style: context.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
      onChanged: onChanged,
    );
  }
}
