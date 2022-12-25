import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/join_us/presentation/widgets/join_us_step.dart';

class JoinUsPage extends StatelessWidget {
  const JoinUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            LocalizedTexts.joinUsIn2Steps.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          JoinUsStep(
                            title: LocalizedTexts.bodyAndMindFitnessCheck.tr(),
                            subtitle: LocalizedTexts.joinUsStepOneDesc.tr(),
                            markLetter: 'A',
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          JoinUsStep(
                            title: LocalizedTexts.whatAreYourPreferences.tr(),
                            subtitle: LocalizedTexts.joinUsStepTwoDesc.tr(),
                            markLetter: 'B',
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipPolygon(
                                  sides: 6,
                                  borderRadius: 15.0,
                                  rotate: 90.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      image: DecorationImage(
                                        image: AppImages.coffee,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18.0,
                              ),
                              Flexible(
                                  child: Text(LocalizedTexts.joinUsNote.tr())),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _onStepFitnessCheckPressed(context),
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.orangeDark),
                                ),
                            child:
                                Text(LocalizedTexts.stepOneFitnessCheck.tr()),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onStepFitnessCheckPressed(BuildContext context) {
    context.router.replaceAll(const [
      HeightRoute(),
    ]);
  }
}
