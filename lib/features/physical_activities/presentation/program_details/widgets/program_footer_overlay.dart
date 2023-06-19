import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class ProgramFooterOverlay extends StatelessWidget {
  const ProgramFooterOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 28.0),
      decoration: BoxDecoration(
        color: AppColors.bgGreen,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: MainContainer(
          child: Column(
            children: [
              const Text(
                LocalizedTexts.programNote,
                textAlign: TextAlign.center,
              ).tr(),
              const SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                onPressed: _onGetStarted,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                    ),
                child: const Text(LocalizedTexts.getStarted).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGetStarted() {}
}
