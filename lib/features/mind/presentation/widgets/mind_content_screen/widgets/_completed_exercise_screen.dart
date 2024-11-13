part of '../mind_content_screen.dart';

class _CompletedExerciseScreen extends StatelessWidget {
  const _CompletedExerciseScreen({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrol(
      appBar: CustomAppBar.petrol(
        title: title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.petrolLighter,
              AppColors.petrolDarker,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomSafeArea(
          child: child,
        ),
      ),
    );
  }
}
