part of '../mind_content_screen.dart';

class _TextExplanationLeadingWidget extends StatelessWidget {
  const _TextExplanationLeadingWidget({
    super.key,
    required this.type,
    required this.url,
  });

  final _MindContentScreenType type;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return switch(type) {
      _MindContentScreenType.exercise => const SizedBox.shrink(),
      _MindContentScreenType.intro => ExerciseListTile(
        exercise: context.read<MindBloc>().state.data.currentExerciseWithoutIntro,
      ),
      _MindContentScreenType.explanation => url != null ? SizedBox(
        height: 276,
        child: NetworkImageWithCache(url: url!),
      ) : SizedBox(),
    };
  }
}
