import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_with_indicator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();

  bool _isDisabled = true;

  Future<bool> _onWillPop() {
    context.read<AuthenticationCubit>().previousStep();

    return Future.value(true);
  }

  void _onNextPressed() {
    context
      ..read<AuthenticationCubit>().changeToEmailState(_passwordController.text)
      ..router.pushNamed(AppRoutes.emailAddress);
  }

  _onPasswordChanged(String password, double passwordStrength) {
    setState(() {
      _isDisabled = passwordStrength < 3 / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
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
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (BuildContext context, state) {
                        return CustomText.bitter700(
                          '${LocalizedTexts.enterPasswordTitle.tr()}, ${state.maybeMap(password: (state) => state.name.capitalize(), orElse: () => '')}!',
                          style: context.textTheme.displayMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 27.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.enterPasswordSubTitle.tr()}?',
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 100.0),
                    PasswordWithIndicator(
                      controller: _passwordController,
                      onChange: _onPasswordChanged,
                    ),
                    const SizedBox(height: 24.0),
                    CustomElevatedButton.blueFullWidth(
                      onPressed: _isDisabled ? null : _onNextPressed,
                      label: LocalizedTexts.confirmPassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }
}
