import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class DeleteAccountSection extends StatelessWidget {
  const DeleteAccountSection({super.key});

  _onDeleteAccountPressed(BuildContext context) {
    ModalBottomSheet.deleteAccount(
      context: context,
      onDeleted: () {
        context.read<AuthenticationCubit>().deleteAccount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          CustomOutlinedButton.coralFullWidth(
            onPressed: () => _onDeleteAccountPressed(context),
            label: LocalizedTexts.deleteAccount.tr(),
          ),
        ],
      ),
    );
  }
}
