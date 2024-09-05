import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activity_validator.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/activity_controller.dart';

class CustomActivityTab extends StatefulWidget {
  const CustomActivityTab({super.key});

  @override
  State<CustomActivityTab> createState() => _CustomActivityTabState();
}

class _CustomActivityTabState extends State<CustomActivityTab> with AutomaticKeepAliveClientMixin {
  final ActivityController controller = ActivityController();

  @override
  bool wantKeepAlive = true;

  void _onLogActivityPressed(BuildContext context) {
    context
      ..read<PhysicalProgramsBloc>().add(
          PhysicalProgramsEvent.createCustomActivity(controller.activityController.text.trim()))
      ..router.popUntilRouteWithName(HomeRoute.name);
  }

  void _onFormChanged() =>
      controller.isFormValid.value = controller.formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScrollableContainer(
      child: Form(
        key: controller.formKey,
        onChanged: _onFormChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.bitter600(
                  LocalizedTexts.whatPhysicalActivityDidYouDo.tr(),
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  key: controller.activityFieldKey,
                  controller: controller.activityController,
                  validator: physicalActivityValidator,
                  keyboardType: TextInputType.multiline,
                  maxLength: 30,
                  maxLines: 2,
                  hintText: '',
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: controller.isFormValid,
              builder: (context, isFormValid, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: isFormValid ? () => _onLogActivityPressed(context) : null,
                    label: LocalizedTexts.confirm.tr(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
