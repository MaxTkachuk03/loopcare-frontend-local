import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class LegalStatementConfirmationBox extends StatefulWidget {
  const LegalStatementConfirmationBox({super.key, this.onChanged});

  final void Function(bool value)? onChanged;

  @override
  State<LegalStatementConfirmationBox> createState() => _LegalStatementConfirmationBoxState();
}

class _LegalStatementConfirmationBoxState extends State<LegalStatementConfirmationBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0, right: 30.0, left: 15.0),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: AppColors.coralLighter, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
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
                  LocalizedTexts.legalStatementCheckboxTitle.tr(),
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                BulletListItem(
                  centered: false,
                  text: CustomText.w400(
                    LocalizedTexts.legalStatementCheckboxItemOne.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  bulletSize: 18.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
      widget.onChanged?.call(value ?? false);
    });
  }
}
