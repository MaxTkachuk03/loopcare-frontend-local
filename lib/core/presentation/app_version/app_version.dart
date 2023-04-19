import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              '${snapshot.data?.version}.${snapshot.data?.buildNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
