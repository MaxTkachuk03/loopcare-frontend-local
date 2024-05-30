import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/name_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _nameController = TextEditingController();
  final _formValidationNotifier = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _formValidationNotifier.dispose();
    super.dispose();
  }

  _onChangedForm() {
    final isValidForm = Name.create(_nameController.text).isRight();
    _formValidationNotifier.value = isValidForm;
  }

  void _onNextPressed() {
    context
      ..read<AuthenticationBloc>().add(AuthenticationEvent.updateName(_nameController.text.trim()))
      ..router.pushNamed(AppRoutes.emailAddress);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: CustomScaffold.blueLightest(
        key: const ValueKey('name_page'),
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.name.tr(),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: CustomSafeArea(
          child: BottomPlacedButton.blueLightest(
            body: MainContainer(
              child: Column(
                key: const ValueKey('name_page_body'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 35.0),
                  CustomText.bitter600(
                    '${LocalizedTexts.whatIsYourName.tr()}?',
                    style: context.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 35.0),
                  Form(
                    key: _formKey,
                    onChanged: _onChangedForm,
                    child: CustomTextField(
                      key: const ValueKey('name_page_text_field'),
                      controller: _nameController,
                      hintText: LocalizedTexts.yourName.tr(),
                      validator: nameValidator(),
                      maxLength: 64,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            button: ValueListenableBuilder<bool>(
              valueListenable: _formValidationNotifier,
              builder: (context, isValid, _) {
                return CustomElevatedButton.blueFullWidth(
                  key: const ValueKey('name_page_next_button'),
                  onPressed: isValid ? _onNextPressed : null,
                  label: LocalizedTexts.next.tr(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
