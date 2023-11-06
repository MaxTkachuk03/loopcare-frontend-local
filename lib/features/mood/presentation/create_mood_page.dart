import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_page_mode.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/delete_mood_btn.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_note_field.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_options.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_picker.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moodPageController.isFormValid;
    });
  }

  String get _btnText => widget.mode.map(
        create: (_) => LocalizedTexts.confirm,
        edit: (_) => LocalizedTexts.update,
      );

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
      edit: (s) => context.read<MoodBloc>().add(MoodEvent.updateMood(moodId: s.moodRecord.id, data: data)),
    );
  }

  void _onDeleteMoodHandler() {
    widget.mode.map(
      create: (_) => null,
      edit: (s) => context
          .read<MoodBloc>()
          .add(MoodEvent.deleteMood(moodId: s.moodRecord.id, date: widget.date.isoStringWithoutTime)),
    );
  }

  void _onChangeListener(BuildContext context, MoodState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  _onErrorHandler(MoodState s) {
    showAppSnackBar(
      context: context,
      text: s.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr(),
      background: AppColors.red,
      textColor: Colors.white,
    );
  }

  _onUpdateHandler(MoodState s) {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: '${LocalizedTexts.mood.tr()} ${widget.date.shortDateWithYear}',
        leading: const BackButtonHexagon(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: BlocListener<MoodBloc, MoodState>(
            listener: _onChangeListener,
            child: MainContainer(
              child: BlocBuilder<MoodBloc, MoodState>(
                builder: (context, state) {
                  return state.maybeMap(
                    loading: (_) => const Loader(),
                    orElse: () => Form(
                      key: _moodPageController.formKey,
                      onChanged: () => _moodPageController.isFormValid,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 34.0),
                          Text(LocalizedTexts.selectMoodText,
                                  style: Theme.of(context).textTheme.headlineSmall)
                              .tr(),
                          const SizedBox(height: 12.0),
                          ValueListenableBuilder<MoodPickerListItem?>(
                            valueListenable: _moodPageController.moodValue,
                            builder: (context, moodValue, _) =>
                                MoodPicker(onItemPressed: _onMoodValueChangeHandler, value: moodValue),
                          ),
                          const SizedBox(height: 12.0),
                          MoodOptions(controller: _moodPageController),
                          const SizedBox(height: 12.0),
                          Text(LocalizedTexts.personalNote, style: Theme.of(context).textTheme.headlineSmall)
                              .tr(),
                          const SizedBox(height: 12.0),
                          MoodNoteField(_moodPageController),
                          const SizedBox(height: 24.0),
                          widget.mode.map(
                            create: (_) => const SizedBox.shrink(),
                            edit: (_) => SizedBox(
                              width: 180,
                              child: DeleteMoodBtn(onPress: _onDeleteMoodHandler),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          ValueListenableBuilder<bool>(
                            valueListenable: _moodPageController.isValid,
                            builder: (context, isValid, _) => ElevatedButton(
                              onPressed: isValid ? _onConfirmPressed : null,
                              child: Text(_btnText).tr(),
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
