import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_list_content/mind_list_content.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/techniques_list_tile/techniques_list_tile.dart';

@RoutePage()
class TechniquesPage extends StatefulWidget {
  const TechniquesPage({super.key});

  @override
  State<TechniquesPage> createState() => _TechniquesPageState();
}

class _TechniquesPageState extends State<TechniquesPage> with MindAnalyticsMixin {
  void listener(BuildContext context, MindState state) {
    state.mapOrNull(
      error: errorHandler,
    );
  }

  void errorHandler(MindState state) => context.showError(
      content: CustomText(state.data.errorKey.tr()));

  Future<void> getTechniques() async =>
      context.read<MindBloc>().add(const MindEvent.getTechniques());

  @override
  void initState() {
    super.initState();
    getTechniques();
    track(AnalyticsEvents.mindOpen);
  }

  @override
  void dispose() {
    track(AnalyticsEvents.mindClose);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrol(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.mindTraining.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: BlocConsumer<MindBloc, MindState>(
          listener: listener,
          buildWhen: (previous, current) => ModalRoute.of(context)?.isCurrent ?? false,
          builder: (context, state) {
            return MindListContent(
              isLoading: state.data.isLoading && state.data.techniques.isEmpty,
              title: state.data.mindInfo?.title ?? '',
              subtitle: state.data.mindInfo?.subtitle ?? '',
              textColor: AppColors.white,
              description: state.data.mindInfo?.shortIntroduction ?? '',
              isVideoExplanation: state.data.mindInfo?.explanation.type.isVideo ?? false,
              onExplanationPressed: () => context.router.pushNamed(AppRoutes.mindExplanation),
              itemCount: state.data.techniques.length,
              itemBuilder: (context, index) {
                final technique = state.data.techniques[index];

                return TechniquesListTile(
                  key: ValueKey('mind_technique_${technique.id}'),
                  technique: technique,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
