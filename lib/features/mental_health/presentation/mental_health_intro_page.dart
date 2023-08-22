import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';

class MentalHealthIntroPage extends StatefulWidget {
  const MentalHealthIntroPage({Key? key}) : super(key: key);

  @override
  State<MentalHealthIntroPage> createState() => _MentalHealthIntroPageState();
}

class _MentalHealthIntroPageState extends State<MentalHealthIntroPage> {
  @override
  void initState() {
    context.read<MentalHealthBloc>().add(const MentalHealthEvent.getMentalHealthTests());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MentalHealthWrap(
      withoutPagination: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24.0,
          ),
          Text(
            LocalizedTexts.yourMentalHealth,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontFamily: ThemeConstants.bitterFontFamily,
                  color: AppColors.blueDark,
                ),
          ).tr(),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            LocalizedTexts.mentalHealthIntroTextOne,
            style: Theme.of(context).textTheme.bodyLarge,
          ).tr(),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            LocalizedTexts.mentalHealthIntroTextTwo,
            style: Theme.of(context).textTheme.bodyLarge,
          ).tr(),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            LocalizedTexts.mentalHealthIntroTextThree,
            style: Theme.of(context).textTheme.bodyLarge,
          ).tr(),
          const SizedBox(
            height: 20.0,
          ),
          SmallFilledButton(
            backgroundColor: AppColors.greyLight,
            text: LocalizedTexts.moreInfo.tr(),
            onPressed: () => {},
          ),
          const SizedBox(
            height: 45.0,
          ),
          ElevatedButton(
            onPressed: () => _onNextPressed(context),
            child: const Text(LocalizedTexts.next).tr(),
          ),
          const SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.mentalHealthQuestion);
  }
}
