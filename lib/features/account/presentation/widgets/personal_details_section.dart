import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: LocalizedTexts.personalDetails),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (BuildContext context, state) {
            return SectionItem(title: LocalizedTexts.name, subTitle: state.name, onPressHandler: () {});
          },
        ),
        const SizedBox(height: 20.0),
        SectionItem(title: LocalizedTexts.height, subTitle: 'Artur', onPressHandler: () {}),
        const SizedBox(height: 20.0),
        SectionItem(title: LocalizedTexts.yourSex, subTitle: 'Artur', onPressHandler: () {}),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
