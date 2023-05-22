import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';

class LegalStatementConfirmationBox extends StatefulWidget {
  const LegalStatementConfirmationBox({Key? key}) : super(key: key);

  @override
  State<LegalStatementConfirmationBox> createState() =>
      _LegalStatementConfirmationBoxState();
}

class _LegalStatementConfirmationBoxState
    extends State<LegalStatementConfirmationBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 34.0,
        right: 22.0,
        left: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: AppColors.yellowLight,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: isChecked, onChanged: _onCheckboxChanged),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocalizedTexts.legalStatementCheckboxTitle.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  BulletListItem(
                    text: Text(
                      LocalizedTexts.legalStatementCheckboxItemOne.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    bulletSize: 18.0,
                  ),
                  BulletListItem(
                    text: Text(
                      LocalizedTexts.legalStatementCheckboxItemTwo.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    bulletSize: 18.0,
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 18.0,
          ),
          ElevatedButton(
            onPressed: isChecked ? _onConfirm : null,
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return AppColors.greyMid;
                  }

                  return AppColors.orangeDark;
                },
              ),
            ),
            child: Text(
              LocalizedTexts.confirm.tr(),
            ),
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
      ..read<LegalStatementBloc>()
          .add(const LegalStatementEvent.passageChanged(true))
      ..router.replaceNamed(AppRoutes.signUpWelcome);
  }
}
