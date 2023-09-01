import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_number_data.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumberCard extends StatelessWidget {
  final EmergencyNumberData number;

  const EmergencyNumberCard({
    Key? key,
    required this.number,
  }) : super(key: key);

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
              onPressed: _onPressed,
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

  Future<void> _onPressed() async {
    if (number.type == EmergencyNumberType.phone) {
      _makePhoneCall(number.number);
    } else if (number.type == EmergencyNumberType.messenger) {
      _launchInBrowser(number.number);
    }
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri launchUri = Uri.parse(url);

    if (!await launchUrl(
      launchUri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
