import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';

class PreIntroPage extends StatelessWidget {
  const PreIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.router.pushNamed(AppRoutes.intro);
    return const SizedBox();
  }
}
