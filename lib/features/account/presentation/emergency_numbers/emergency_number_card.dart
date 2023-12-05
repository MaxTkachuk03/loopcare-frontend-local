import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_number_data.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              number.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: () => _onPressed(context),
              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        width: 1.0,
                        color: AppColors.blueDark,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColors.blueDark),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _getIcon() ?? const SizedBox.shrink(),
                  ),
                  Text(
                    number.btnTxt,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon? _getIcon() {
    if (number.type == EmergencyNumberType.phone) {
      return const Icon(Icons.call, size: 16.0, color: Colors.white);
    } else if (number.type == EmergencyNumberType.messenger) {
      return const Icon(Icons.message, size: 16.0, color: Colors.white);
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
