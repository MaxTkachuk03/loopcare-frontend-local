import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';

class CompleteReflectionSection extends StatelessWidget {
  const CompleteReflectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Melissa, its all about you',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: ThemeConstants.bitterFontFamily,
                  color: AppColors.blueDark,
                ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'Is the LeanOnMe program helping you reach your goals?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ScoringScale(
            selectedScore: 10,
            onScoreTap: _onScoreTap,
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Not at all helpful',
                style: TextStyle(fontSize: ThemeConstants.fontSize13, color: AppColors.greyLabel),
              ),
              Text(
                'Extremely helpful',
                style: TextStyle(fontSize: ThemeConstants.fontSize13, color: AppColors.greyLabel),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            color: const Color(0xFFF0FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Maybe certain elements of the program are not working well for you?'),
                const SizedBox(
                  height: 16.0,
                ),
                OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                        minimumSize: MaterialStateProperty.all(const Size(0, 34.0)),
                      ),
                  onPressed: () => {},
                  child: const Text('Tune program setup'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            color: const Color(0xFFF0FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Is there anything else we can do or change to help?'),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  enableSuggestions: false,
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.blueMid,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.blueMid,
                        width: 1.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Complete reflection'),
          ),
        ],
      ),
    );
  }

  void _onScoreTap(int tabIndex) {}
}
