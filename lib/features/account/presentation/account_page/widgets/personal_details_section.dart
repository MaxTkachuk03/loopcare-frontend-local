import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, state) {
        return AccountContainer(
          child: Column(
            children: [
              SectionTitle(
                title: LocalizedTexts.personalDetails.tr(),
              ),
              SectionItem(
                title: LocalizedTexts.height.tr(),
                subTitle: '${state.data.height}',
                onPressHandler: () {},
              ),
              const Divider(height: 1.0, color: AppColors.blueLighter),
              SectionItem(
                title: LocalizedTexts.yourSex.tr(),
                subTitle: state.data.gender?.name.capitalize(),
                onPressHandler: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
