import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/password_with_indicator/password_with_indicator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();

  bool _isDisabled = true;

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocalizedTexts.createAccount.tr()),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (BuildContext context, state) {
                        return Text(
                          LocalizedTexts.enterPasswordTitle.tr(namedArgs: {
                            'name': state.maybeMap(
                                password: (state) => state.name,
                                orElse: () => ''),
                          }),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                              ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    PasswordWithIndicator(
                      controller: _passwordController,
                      onChange: _onPasswordChanged,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _isDisabled ? null : _onNextPressed,
                      child: Text(LocalizedTexts.confirmPassword.tr()),
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
      _isDisabled = passwordStrength != 1.0;
    });
  }
}
