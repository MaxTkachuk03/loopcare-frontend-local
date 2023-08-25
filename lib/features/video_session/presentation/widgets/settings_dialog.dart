import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  final void Function() onToggleSpeaker;
  final void Function() onToggleAspectRatio;
  final bool isSpeakerOn;

  const SettingsDialog({
    super.key,
    required this.onToggleSpeaker,
    required this.onToggleAspectRatio,
    required this.isSpeakerOn,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 116,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView(
              shrinkWrap: true,
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: Text('Toggle speaker ${isSpeakerOn ? 'off' : 'on'}'),
                    onTap: () {
                      onToggleSpeaker();
                      context.router.pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Toggle camera aspect ratio'),
                    onTap: () {
                      onToggleAspectRatio();
                      context.router.pop();
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
