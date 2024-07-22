import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class ReflectionCompletePage extends StatelessWidget {
  final RiverModuleStreamType streamType;

  const ReflectionCompletePage({super.key, this.streamType = RiverModuleStreamType.psychology});

  _onPressHandler(BuildContext context) {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: streamType.offRegularColor,
      appBar: CustomAppBar(
        backgroundColor: streamType.regularColor,
        textTheme: streamType.appBarTextTheme,
        title: LocalizedTexts.lesson.tr(),
        leading: CustomFilledIconButton.fromColor(color: streamType.lighterColor),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UnderAppbar.petrol(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                              backgroundColor: AppColors.greenRegular,
                              child: Icon(Icons.check, size: 24, color: AppColors.white),
                            ),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              '${LocalizedTexts.assignmentCompleted.tr()}!',
                              style:
                                  context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  MainContainer(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.petrolLightest,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: BlocBuilder<ReflectionsBloc, ReflectionsState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoryLabel.reflection(),
                              const SizedBox(height: 20.0),
                              CustomText.bitter600(
                                state.data.activeReflection?.title ?? '',
                                style: context.textTheme.displayLarge,
                              ),
                              const SizedBox(height: 20.0),
                              CustomText.w400(
                                LocalizedTexts.assignmentCompleteDescription.tr(),
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MainContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: () => _onPressHandler(context),
                    label: LocalizedTexts.complete.tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
