import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: MainContainer(
            child: Column(
              children: [
                Text(
                  'Home page!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _onLogOutPressed(context),
                  child: const Text('Log out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onLogOutPressed(BuildContext context) {
    context.read<AuthenticationCubit>().logout();
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
