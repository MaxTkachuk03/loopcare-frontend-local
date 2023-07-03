import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: ThemeConstants.fontSize11, color: AppColors.darkGreen),
                  children: [
                    TextSpan(
                      text: 'Now: ',
                    ),
                    TextSpan(
                      text: 'Discussion',
                      style: TextStyle(
                        fontSize: ThemeConstants.fontSize11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: '- 19 minutes left')
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: ThemeConstants.fontSize11, color: AppColors.darkGreen),
                  children: [
                    TextSpan(
                      text: 'Next up: ',
                    ),
                    TextSpan(
                      text: 'Wrap up',
                      style: TextStyle(
                        fontSize: ThemeConstants.fontSize11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 36.0,
          ),
          Text(
            'What does your eating \nbehavior look like today?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 36.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 34.0,
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: AppColors.blueDark,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Text(
                  'SOS',
                  style: TextStyle(
                      fontSize: ThemeConstants.fontSize11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blueDark),
                ),
              ),
              const Text(
                '0 of 9 are ready to continue',
                style: TextStyle(
                  fontSize: ThemeConstants.fontSize12,
                ),
              ),
              SizedBox(
                width: 98.0,
                height: 32.0,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
