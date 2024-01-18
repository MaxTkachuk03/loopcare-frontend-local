import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';

class LegalStatementConfirmationBox extends StatefulWidget {
  const LegalStatementConfirmationBox({super.key});

  @override
  State<LegalStatementConfirmationBox> createState() => _LegalStatementConfirmationBoxState();
}

class _LegalStatementConfirmationBoxState extends State<LegalStatementConfirmationBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 34.0, bottom: 34.0, right: 22.0, left: 25.0),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: AppColors.coralLighter, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckbox.green(value: isChecked, onChanged: _onCheckboxChanged),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CustomText.w700(
                      '${LocalizedTexts.legalStatementCheckboxTitle.tr()}:',
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8.0),
                    BulletListItem(
                      centered: false,
                      text: CustomText.w400(
                        '${LocalizedTexts.legalStatementCheckboxItemOne.tr()}.',
                        style: context.textTheme.bodyMedium,
                      ),
                      bulletSize: 18.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          CustomElevatedButton.blueFullWidth(
            onPressed: isChecked ? _onConfirm : null,
            label: LocalizedTexts.confirm,
          ),
        ],
      ),
    );
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  void _onConfirm() {
    context
      ..read<LegalStatementBloc>().add(const LegalStatementEvent.passageChanged(true))
      ..router.replaceNamed(AppRoutes.signUpWelcome);
  }
}
