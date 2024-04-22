part of '../mind_content_screen.dart';

class _TextExplanationLeadingWidget extends StatelessWidget {
  const _TextExplanationLeadingWidget({
    super.key,
    required this.type,
    required this.url,
  }) : assert(
        type == _MindContentScreenType.explanation && url != null || type != _MindContentScreenType.explanation,
        'Parameter {url} required for {type} [_MindContentScreenType.intro] and [_MindContentScreenType.explanation]',
      );

  final _MindContentScreenType type;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return switch(type) {
      _MindContentScreenType.exercise => const SizedBox.shrink(),
      _MindContentScreenType.intro => ExerciseListTile(
        exercise: context.read<MindBloc>().state.data.currentExerciseWithoutIntro,
      ),
      _MindContentScreenType.explanation => SizedBox(
        height: 276,
        child: NetworkImageWithCache(url: url!),
      ),
    };
  }
}
