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
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/widgets/email_address_form.dart';

class EmailAddressPage extends StatelessWidget {
  const EmailAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.read<AuthenticationBloc>().state.data.nameCapitalised;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold.greenLightest(
        key: const ValueKey('email_address_page'),
        appBar: CustomAppBar.green(
          title: LocalizedTexts.email.tr(),
          leading: CustomFilledIconButton.leadingGreenLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                key: const ValueKey('email_page_body'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 35.0),
                  CustomText.bitter700(
                    '${LocalizedTexts.niceToMeetYou.tr()}, $userName!',
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 27.0),
                  CustomText.bitter600(
                    '${LocalizedTexts.emailTitle.tr()}.',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28.0),
                  const EmailAddressForm(
                    key: ValueKey('email_form'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
