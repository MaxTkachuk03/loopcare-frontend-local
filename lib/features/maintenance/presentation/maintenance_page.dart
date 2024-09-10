import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

@RoutePage()
class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.transparent(
        leading: const SizedBox.shrink(),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: CustomPaint(
          painter: const MaintenanceBackgroundPainter(),
          child: MainContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 120),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CategoryLabel.maintenance(),
                ),
                const SizedBox(height: 32),
                CustomText.bitter600(
                  LocalizedTexts.maintenancePageTitle.tr(),
                  style: context.textTheme.displayMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 20),
                CustomText.w400(
                  LocalizedTexts.maintenancePageDescription.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MaintenanceBackgroundPainter extends CustomPainter {
  const MaintenanceBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height > 100);

    final paint = Paint()..color = AppColors.blueDarker;
    final path = Path()
      ..moveTo(0, 51)
      ..lineTo(size.width * 0.06, 33)
      ..cubicTo(size.width * 0.18, -3, size.width * 0.36, -10, size.width * 0.51, 14)
      ..lineTo(size.width, 94)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 51)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
