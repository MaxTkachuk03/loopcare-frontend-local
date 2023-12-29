import 'package:easy_localization/easy_localization.dart';
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
          child: Column(
            children: [
              SectionTitle(
                title: LocalizedTexts.personalDetails.tr(),
              ),
              SectionItem(
                title: LocalizedTexts.name.tr(),
                subTitle: state.name,
                onPressHandler: () {},
              ),
              const Divider(height: 1.0, color: AppColors.blueLighter),
              SectionItem(
                title: LocalizedTexts.height.tr(),
                subTitle: '${state.height}',
                onPressHandler: () {},
              ),
              const Divider(height: 1.0, color: AppColors.blueLighter),
              SectionItem(
                title: LocalizedTexts.yourSex.tr(),
                subTitle: state.gender?.name.capitalize(),
                onPressHandler: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
