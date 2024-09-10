part of '../mental_health_question_content.dart';

class _MentalHealthChoiceChip extends StatefulWidget {
  const _MentalHealthChoiceChip({
    required this.questionId,
    required this.options,
    required this.onChanged,
  });

  final int questionId;
  final void Function(int? value) onChanged;
  final List<MentalHealthOption> options;

  @override
  State<_MentalHealthChoiceChip> createState() => _MentalHealthChoiceChipState();
}

class _MentalHealthChoiceChipState extends State<_MentalHealthChoiceChip> {
  late int? _selectedOptionId;

  @override
  void initState() {
    super.initState();
    _setSelectedItem();
  }

  @override
  void didUpdateWidget(covariant _MentalHealthChoiceChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setSelectedItem();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomChoiceChip.petrol(
                label: item.title,
                selected: _selectedOptionId == item.id,
                onSelected: (value) => _onSelected(value),
                value: item.id,
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }

  void _setSelectedItem() {
    _selectedOptionId = context
        .read<MentalQuestionsBloc>()
        .state
        .answers
        .firstWhereOrNull((element) => element.questionId == widget.questionId)
        ?.optionId;

    if (_selectedOptionId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onChanged(_selectedOptionId));
    }
  }

  void _onSelected(int value) {
    _selectedOptionId = value;
    widget.onChanged(_selectedOptionId);
    setState(() {});
  }
}
