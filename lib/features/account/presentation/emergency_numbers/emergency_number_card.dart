import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_number_data.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button_with_icon.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumberCard extends StatelessWidget {
  final EmergencyNumberData number;

  const EmergencyNumberCard({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomText.w700(number.title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(
            child: SizedBox(
              height: 30.0,
              child: CustomOutlinedButtonWithIcon.coralFullWidth(
                onPressed: () => _onPressed(context),
                label: number.btnTxt,
                icon: _getIcon() ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon? _getIcon() {
    if (number.type == EmergencyNumberType.phone) {
      return const Icon(Icons.call, size: 16.0, color: AppColors.blueDarker);
    } else if (number.type == EmergencyNumberType.messenger) {
      return const Icon(Icons.message, size: 16.0, color: AppColors.blueDarker);
    }
    return null;
  }

  Future<void> _onPressed(BuildContext context) async {
    if (number.type == EmergencyNumberType.phone) {
      _makePhoneCall(number.number, context);
    } else if (number.type == EmergencyNumberType.messenger) {
      _launchInBrowser(number.number, context);
    }
  }

  void _showError(BuildContext context) =>
      context.showError(content: Text(LocalizedTexts.openLinkErrorMessage.translation));

  Future<void> _launchInBrowser(String url, BuildContext context) async {
    final Uri launchUri = Uri.parse(url);

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      _showError(context);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      await launchUrl(launchUri);
    } catch (e) {
      _showError(context);
    }
  }
}
