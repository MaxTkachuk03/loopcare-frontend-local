import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/widgets/email_address_form.dart';

class EmailAddressPage extends StatelessWidget {
  const EmailAddressPage({super.key});

  Future<bool> _onWillPop(BuildContext context) {
    context.read<AuthenticationCubit>().previousStep();

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: CustomScaffold.greenLightest(
          appBar: CustomAppBar.green(
            title: LocalizedTexts.createAccount.tr(),
            leading: CustomFilledIconButton.leadingGreenLighter(),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 35.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.emailTitle.tr()}?',
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8.0),
                    CustomText.w400(
                      '${LocalizedTexts.emailBody.tr()}.',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28.0),
                    const EmailAddressForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
