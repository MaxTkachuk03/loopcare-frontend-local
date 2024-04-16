import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_view_content/mind_view_content.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/techniques_list_tile/techniques_list_tile.dart';

class TechniquesPage extends StatefulWidget {
  const TechniquesPage({super.key});

  @override
  State<TechniquesPage> createState() => _TechniquesPageState();
}

class _TechniquesPageState extends State<TechniquesPage> {

  void listener(BuildContext context, MindState state) {
    state.mapOrNull(
      error: errorHandler,
    );
  }

  void errorHandler(MindState state) =>
      context.showError(content: Text(state.data.error?.error?.message ?? LocalizedTexts.somethingWentWrong.tr()));

  @override
  void initState() {
    super.initState();
    context.read<MindBloc>().add(const MindEvent.getTechniques());
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
          // Todo: add update technique event listener
          buildWhen: (previous, current) => previous.data.techniques.isEmpty,
          builder: (context, state) {

            return MindViewContent(
              isLoading: state.data.isLoading && state.data.techniques.isEmpty,
              title: state.data.program?.title ?? '',
              subtitle: state.data.program?.subtitle ?? '',
              textColor: AppColors.white,
              description: state.data.program?.shortIntroduction ?? '',
              onLearnMorePressed: () {
                // state.data.program?.explanation.src;
              },
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
