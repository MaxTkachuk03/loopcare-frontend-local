import 'package:auto_route/auto_route.dart';
import 'package:customer_io/customer_io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_events.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/dashboard/domain/dashboard_utils.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_page_mode.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/delete_mood_btn.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_note_field.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_options.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_picker.dart';

@RoutePage()
class CreateMoodPage extends StatefulWidget {
  final MoodPageMode mode;
  final DateTime date;

  const CreateMoodPage({super.key, required this.mode, required this.date});

  @override
  State<CreateMoodPage> createState() => _CreateMoodPageState();
}

class _CreateMoodPageState extends State<CreateMoodPage> {
  late MoodController _moodPageController;

  @override
  void initState() {
    super.initState();

    final currentMoment = DateTime.now();

    final initialDateTime = DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      currentMoment.hour,
      currentMoment.minute,
      currentMoment.second,
    );

    _moodPageController = widget.mode.map(
      create: (_) => MoodController()
        ..setTimeValue(initialDateTime)
        ..addFocusNodeListeners(),
      edit: (s) => MoodController()
        ..setMoodInitialValues(s.moodRecord)
        ..addFocusNodeListeners(),
    );
    CustomerIO.track(
      name: CIOEvents.moodWidget,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moodPageController.isFormValid;
    });
  }

  void _onMoodValueChangeHandler(MoodPickerListItem item) {
    _moodPageController.setMoodValue(item);
    _moodPageController.isFormValid;
  }

  void _onConfirmPressed() {
    final data = Mood(
      scale: _moodPageController.moodScaleValue,
      time: _moodPageController.loggingDate.toUtc(),
      emotion: _moodPageController.moodEmotionString,
      person: _moodPageController.moodWithWhoValue,
      location: _moodPageController.moodWhereValue,
      food: _moodPageController.moodFoodValue,
      note: _moodPageController.noteController.text,
      loggingDate: _moodPageController.loggingDate.toUtc(),
    );

    widget.mode.map(
      create: (_) => context.read<MoodBloc>().add(MoodEvent.createMood(data)),
      edit: (s) =>
          context.read<MoodBloc>().add(MoodEvent.updateMood(moodId: s.moodRecord.id, data: data)),
    );
  }

  void _onDeleteMoodHandler() {
    widget.mode.map(
      create: (_) => null,
      edit: (s) => context.read<MoodBloc>().add(
          MoodEvent.deleteMood(moodId: s.moodRecord.id, date: widget.date.isoStringWithoutTime)),
    );
  }

  void _onChangeListener(BuildContext context, MoodState state) {
    state.mapOrNull(
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  _onErrorHandler(MoodState s) => context.showError(content: CustomText(s.data.errorKey.tr()));

  _onUpdateHandler(MoodState s) => context.router.maybePop();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.orangeLightest(
      appBar: CustomAppBar.orange(
        title: LocalizedTexts.mood.tr(),
        subtitle: widget.date.shortDateWithYear,
        leading: CustomFilledIconButton.leadingOrangeLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: BlocListener<MoodBloc, MoodState>(
            listener: _onChangeListener,
            child: MainContainer(
              child: BlocBuilder<MoodBloc, MoodState>(
                builder: (context, state) {
                  final bool isEditable = DashboardUtils.isEditable(widget.date);

                  return state.maybeMap(
                    loading: (_) => const Loader(),
                    orElse: () => Form(
                      key: _moodPageController.formKey,
                      onChanged: () => _moodPageController.isFormValid,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 34.0),
                          CustomText.bitter500(
                            LocalizedTexts.selectMoodText.tr(),
                            style: context.textTheme.displayMedium,
                          ),
                          CustomText.w400(
                            LocalizedTexts.selectMoodSubtext.tr(),
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12.0),
                          ValueListenableBuilder<MoodPickerListItem?>(
                            valueListenable: _moodPageController.moodValue,
                            builder: (context, moodValue, _) => MoodPicker(
                                onItemPressed: isEditable ? _onMoodValueChangeHandler : null,
                                value: moodValue),
                          ),
                          const SizedBox(height: 12.0),
                          MoodOptions(controller: _moodPageController, isEditable: isEditable),
                          const SizedBox(height: 12.0),
                          CustomText.bitter500(
                            LocalizedTexts.personalNote.tr(),
                            style: context.textTheme.displayMedium,
                          ),
                          const SizedBox(height: 12.0),
                          MoodNoteField(_moodPageController, !isEditable),
                          const SizedBox(height: 24.0),
                          widget.mode.map(
                            create: (_) => const SizedBox.shrink(),
                            edit: (_) => DeleteMoodBtn(onPress: _onDeleteMoodHandler),
                          ),
                          const SizedBox(height: 24.0),
                          ValueListenableBuilder<bool>(
                            valueListenable: _moodPageController.isValid,
                            builder: (context, isValid, _) => CustomElevatedButton.blueFullWidth(
                              onPressed: isValid && isEditable ? _onConfirmPressed : null,
                              label: LocalizedTexts.logMood.tr(),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _moodPageController.dispose();

    super.dispose();
  }
}
