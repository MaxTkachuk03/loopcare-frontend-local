import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.diabetes.tr()),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 29.0,
                    right: 31.0,
                    bottom: 48.0,
                    left: 40.0,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${LocalizedTexts.diabetesDisclaimerTitle.tr()}: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      BlocBuilder<DiabetesBloc, DiabetesState>(
                        builder: (BuildContext context, state) {
                          final type = state.selectedType?.name.split(', ')[1];

                          return Text(
                            '${type?.capitalizeOnlyFirstLetter()}',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: AppColors.blueDark,
                                    ),
                          );
                        },
                      ),
                      const SizedBox(height: 32.0),
                      Text(
                        LocalizedTexts.diabetesDisclaimerParagraphOne.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 32.0),
                      Text(
                        LocalizedTexts.diabetesDisclaimerParagraphTwo.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 32.0),
                      Text(
                        LocalizedTexts.diabetesDisclaimerParagraphThree.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _onNextPressed(context),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(LocalizedTexts.next.tr()),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.diabetesSummary);
  }
}
