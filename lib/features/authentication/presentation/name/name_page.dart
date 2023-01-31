import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name.dart';
import 'package:loopcare_frontend/core/presentation/validators/name_validator.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _nameController = TextEditingController();

  bool _isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  Text(
                    LocalizedTexts.whatIsYourName.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    LocalizedTexts.namePageDescription.tr(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Form(
                    key: _formKey,
                    onChanged: _onChangedForm,
                    child: Column(
                      children: [
                        Field(
                          controller: _nameController,
                          hintText: LocalizedTexts.yourName.tr(),
                          validator: nameValidator(),
                          maxLength: 64,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _isDisabled ? null : _onNextPressed,
                          child: Text(LocalizedTexts.next.tr()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onChangedForm() {
    final isValidForm = Name.create(_nameController.text).isRight();

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _onNextPressed() {
    context
      ..read<AuthenticationCubit>().changeGuestName(_nameController.text)
      ..router.pushNamed(AppRoutes.password);
  }
}
