import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  void _openProxy(BuildContext context) {
    if (kIsDev) {
      context.router.pushNamed(AppRoutes.proxy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onDoubleTap: () => _openProxy(context),
              child: Text(
                'Version ${snapshot.data?.version} (${snapshot.data?.buildNumber})',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
