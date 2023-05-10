import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('User account'),
                ElevatedButton(
                  onPressed: () => _onDeleteAccountPressed(context),
                  child: const Text('Delete My Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onDeleteAccountPressed(BuildContext context) {
    ModalBottomSheet.deleteAccount(
      context: context,
      onDeleted: () {
        context.read<AuthenticationCubit>().deleteAccount();
      },
    );
  }
}
