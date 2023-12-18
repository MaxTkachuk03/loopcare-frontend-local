import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (BuildContext context, state) {
        return AccountContainer(
          child: Column(children: [
            const SectionTitle(title: LocalizedTexts.personalDetails),
            SectionItem(title: LocalizedTexts.name, subTitle: state.name, onPressHandler: () {}),
            const Divider(height: 1.0, color: AppColors.yellowLight),
            SectionItem(title: LocalizedTexts.height, subTitle: '${state.height}', onPressHandler: () {}),
            const Divider(height: 1.0, color: AppColors.yellowLight),
            SectionItem(
                title: LocalizedTexts.yourSex, subTitle: state.gender?.name.capitalize(), onPressHandler: () {}),
          ]),
        );
      },
    );
  }
}
