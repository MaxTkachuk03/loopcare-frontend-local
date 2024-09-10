import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_button.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_header_label.dart';

class SubscriptionNonrenewablePage extends StatelessWidget {
  const SubscriptionNonrenewablePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      body: BottomPlacedButton.blueLightest(
        body: ScrollableContainer(
          child: Column(
            children: [
              AppImages.subscriptionTop,
              CustomText.bitter600(
                LocalizedTexts.subscriptionRenewedTitle.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge,
              ),
              const SubscriptionHeaderLabel(label: LocalizedTexts.subscriptionRenewedLabel),
            ],
          ),
        ),
        button: RenewButton(
          onTap: () => context.router.replaceNamed(AppRoutes.home),
        ),
      ),
    );
  }
}
