import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:health_kit_reporter/health_kit_reporter.dart';
import 'package:health_kit_reporter/model/predicate.dart';
import 'package:health_kit_reporter/model/type/quantity_type.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/activity_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';

class MultipleSelect extends StatefulWidget {
  const MultipleSelect(
      {super.key,
      required this.component,
      required this.onSaveProgress,
      required this.lessonStreamType});

  final InteractiveLessonChunkComponentMultipleSelect component;
  final RiverModuleStreamType lessonStreamType;

  final Function(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component)
      onSaveProgress;
  @override
  State<MultipleSelect> createState() => _MultipleSelectState();
}

class _MultipleSelectState extends State<MultipleSelect> {
  final List<ContentSelectAnswer> _selectedAnswers = [];
  bool isButtonDisabled = true;
  final lessonStreamType = RiverModuleStreamType;
  double stepCount = 0;

  @override
  void initState() {
    if (widget.component.progress == null) {
      return;
    }
    final history = widget.component.progress!.optionIds!;
    final answers = widget.component.content.answers;
    answers.map((o) {
      for (int i = 0; i < history.length; i++) {
        if (o.id == history[i]) {
          _selectedAnswers.add(o);
        }
      }
    }).toList();
    super.initState();
  }

  Future<void> callBloc(List<Map<String, dynamic>> body) async {
    final bloc = context.read<ActivityBloc>();
    bloc.add(ActivityEvent.saveActivity(body));
  }

  Future<void> _getStepCount() async {
    if (Platform.isIOS) {
      try {
        final now = DateTime.now();
        List<Map<String, dynamic>> body = [];

        for (int i = 179; i >= 0; i--) {
          final day = now.subtract(Duration(days: i));
          final startOfDay = DateTime(day.year, day.month, day.day);
          final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);
          final predicate = Predicate(startOfDay, endOfDay);

          final steps = await HealthKitReporter.quantityQuery(
            QuantityType.stepCount,
            'count',
            predicate,
          );

          double totalSteps = 0;
          for (final step in steps) {
            totalSteps += step.harmonized.value;
          }

          final formattedDate = startOfDay.toIso8601String().split('T')[0];

          if (totalSteps != 0) {
            body.add({"loggingDate": formattedDate, "steps": totalSteps});
          }
        }

        await callBloc(body);
      } catch (e) {
        e;
      }
    }
    if (Platform.isAndroid) {
      try {
        final today = DateTime.now();
        final startTime = DateTime(today.year, today.month, today.day - 180);
        final endTime = DateTime(today.year, today.month, today.day, 23, 59, 59);

        final stepRecords = await HealthConnectFactory.getRecord(
          type: HealthConnectDataType.Steps,
          startTime: startTime,
          endTime: endTime,
        );

        if (stepRecords['records'] != null) {
          List<dynamic> records = stepRecords['records'];

          Map<String, int> dailyStepCounts = {};

          for (var record in records) {
            final count = (record['count'] ?? 0) as int;

            final startEpoch = record['startTime']['epochSecond'] ?? 0;
            final startDate = DateTime.fromMillisecondsSinceEpoch(startEpoch * 1000);
            final loggingDate =
                "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

            dailyStepCounts.update(loggingDate, (value) => value + count, ifAbsent: () => count);
          }

          List<Map<String, dynamic>> formattedSteps = dailyStepCounts.entries.map((entry) {
            return {
              "loggingDate": entry.key,
              "steps": entry.value,
            };
          }).toList();

          callBloc(formattedSteps);
        }
      } catch (e) {
        e;
      }
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      final readTypes = <String>[
        QuantityType.stepCount.identifier,
      ];
      final writeTypes = <String>[];
      final isAuthorized = await HealthKitReporter.requestAuthorization(readTypes, writeTypes);
      if (isAuthorized) {
        return true;
      }
      return false;
    }

    if (Platform.isAndroid) {
      final dataTypes = [HealthConnectDataType.Steps];
      final hasPermission = await HealthConnectFactory.hasPermissions(dataTypes);
      if (!hasPermission) {
        final granted = await HealthConnectFactory.requestPermissions(dataTypes);
        return granted;
      } else {
        return true;
      }
    }

    return false;
  }

  Future<bool> _requestPermission() async {
    if (Platform.isIOS) {
      final readTypes = <String>[
        QuantityType.stepCount.identifier,
      ];
      final writeTypes = <String>[];
      final isAuthorized = await HealthKitReporter.requestAuthorization(readTypes, writeTypes);
      if (isAuthorized) {
        _getStepCount();
        return true;
      }
      return false;
    }

    if (Platform.isAndroid) {
      final dataTypes = [HealthConnectDataType.Steps];
      final hasPermission = await HealthConnectFactory.hasPermissions(dataTypes);
      if (!hasPermission) {
        final granted = await HealthConnectFactory.requestPermissions(dataTypes);
        return granted;
      } else {
        _getStepCount();
        return true;
      }
    }

    return false;
  }

  void revokePermissions() async {
    if (Platform.isIOS) {
      const url = 'x-apple-health';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    if (Platform.isAndroid) {
      HealthConnectFactory.openHealthConnectSettings();
    }
  }

  void _onSelected(ContentSelectAnswer value) {
    if (_selectedAnswers.contains(value) && _selectedAnswers.length == 1) {
      return;
    }

    setState(() {
      isButtonDisabled = false;
      final bloc = context.read<InteractiveLessonsBloc>();
      final blocState = bloc.state.data.iconType;
      if (blocState == 'foot') {
        _selectedAnswers.length = 0;
      }
      _selectedAnswers.contains(value)
          ? _selectedAnswers.remove(value)
          : _selectedAnswers.add(value);
    });
  }

  Future<void> _onCheckOrderHandler() async {
    final order = _selectedAnswers.map((o) => o.id).toList();
    final progress =
        InteractiveLessonComponentProgress(optionIds: order, type: widget.component.type.name);

    final bloc = context.read<InteractiveLessonsBloc>();
    final blocState = bloc.state.data.iconType;

    final saveCount = (blocState == 'foot') ? 2 : 1;

    for (int i = 0; i < saveCount; i++) {
      widget.onSaveProgress(progress, widget.component);
    }

    final selected = _selectedAnswers.map((o) => o.id).toList();
    if (selected.contains(1) && blocState == 'foot') {
      _requestPermission();

      if (Platform.isIOS) {
        await _requestPermission().then((isAuthorized) {
          if (isAuthorized) {
            revokePermissions();
          }
        });
      }
    }
    if (selected.contains(2) && blocState == 'foot') {
      if (await _checkPermission()) {
        revokePermissions();
      }
    }

    setState(() {
      isButtonDisabled = true;
    });
  }

  SelectContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsMultipleSelectLabel.tr(),
          lessonStreamType: widget.lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(
          content.question,
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: content.answers.length,
          itemBuilder: (context, index) {
            final answer = content.answers[index];
            final isSelected = _selectedAnswers.contains(answer);

            return CustomChoiceChip.green(
              label: answer.label,
              selected: isSelected,
              value: answer,
              onSelected: _onSelected,
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CustomElevatedButton.blueFullWidth(
          onPressed: isButtonDisabled ? null : _onCheckOrderHandler,
          label: LocalizedTexts.interactiveLessonsMultipleChoiceBtnLabel.tr(),
        ),
      ],
    );
  }
}
