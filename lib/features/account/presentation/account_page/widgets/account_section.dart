import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item_toggler.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  bool _useFaceId = false;
  bool _requireLogin = false;

  _onUseFaceIdToggle(bool? value) {
    setState(() {
      _useFaceId = value ?? false;
    });
  }

  _onRequireLogin(bool? value) {
    setState(() {
      _requireLogin = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32.0),
        const SectionTitle(title: LocalizedTexts.account),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (BuildContext context, state) {
            return SectionItem(title: LocalizedTexts.username, subTitle: state.email, onPressHandler: () {});
          },
        ),
        const SizedBox(height: 10.0),
        SectionItem(title: LocalizedTexts.changePassword, onPressHandler: () {}),
        const SizedBox(height: 10.0),
        SectionItemToggler(
          title: LocalizedTexts.useFaceOrTouchId,
          value: _useFaceId,
          onPressHandler: _onUseFaceIdToggle,
        ),
        const SizedBox(height: 10.0),
        SectionItemToggler(
          title: LocalizedTexts.requireLoginEachTime,
          value: _requireLogin,
          onPressHandler: _onRequireLogin,
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
