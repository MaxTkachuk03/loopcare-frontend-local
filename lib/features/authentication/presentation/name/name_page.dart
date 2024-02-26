import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/name_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

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

  Future<bool> _onWillPop() {
    context.read<AuthenticationCubit>().previousStep();

    return Future.value(true);
  }

  _onChangedForm() {
    final isValidForm = Name.create(_nameController.text).isRight();

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _onNextPressed() {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userName,
      parameters: {
        CustomDefinitions.value: _nameController.text.trim(),
      },
    );

    context
      ..read<AuthenticationCubit>().changeToPasswordState(_nameController.text.trim())
      ..router.pushNamed(AppRoutes.password);
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
                    CustomText.bitter600(
                      '${LocalizedTexts.whatIsYourName.tr()}?',
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 92.0),
                    Form(
                      key: _formKey,
                      onChanged: _onChangedForm,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            hintText: LocalizedTexts.yourName.tr(),
                            validator: nameValidator(),
                            maxLength: 64,
                          ),
                          const SizedBox(height: 24.0),
                          CustomElevatedButton.blueFullWidth(
                            onPressed: _isDisabled ? null : _onNextPressed,
                            label: LocalizedTexts.next.tr(),
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
      ),
    );
  }
}
