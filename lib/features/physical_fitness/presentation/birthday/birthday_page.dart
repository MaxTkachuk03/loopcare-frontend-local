import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/widgets/birthday_field.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';

class BirthdayPage extends StatelessWidget {
  const BirthdayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainContainer(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  LocalizedTexts.yourBirthday.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
          const BirthdayField(),
        ],
      ),
    );
  }
}
