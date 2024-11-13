import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';

class SettingsDialog extends StatelessWidget {
  final void Function() onToggleSpeaker;
  final bool isSpeakerOn;

  const SettingsDialog({
    super.key,
    required this.onToggleSpeaker,
    required this.isSpeakerOn,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 58,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView(
              shrinkWrap: true,
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: CustomText.w400('Toggle speaker ${isSpeakerOn ? 'off' : 'on'}'),
                    onTap: () {
                      onToggleSpeaker();
                      context.router.maybePop();
                    },
                  ),
                ],
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
