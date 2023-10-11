import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/instructions_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class HaveToAsk extends StatefulWidget {
  const HaveToAsk({Key? key}) : super(key: key);

  @override
  State<HaveToAsk> createState() => _HaveToAskState();
}

class _HaveToAskState extends State<HaveToAsk> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Container(
        padding: const EdgeInsets.only(top: 34, right: 40, left: 40, bottom: 80),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizedTexts.offCourseNoProblem.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(LocalizedTexts.asSoonAsYouReceiveAnswer.tr(), style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: 16.0,
            ),
            Text(LocalizedTexts.youCanDownloadTheInstruction.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _onDownloadInstructionsPressed(context),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStateProperty.all(AppColors.bgGreen),
                    foregroundColor: MaterialStateProperty.all(AppColors.black),
                  ),
              child: Text(LocalizedTexts.downloadInstructions.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDownloadInstructionsPressed(BuildContext context) async {
    InstructionsService.downloadInstructions(onErrorCb: _showError(context));
  }

  _showError(BuildContext context) => () {
        showAppSnackBar(
          context: context,
          text: LocalizedTexts.openLinkErrorMessage.tr(),
          background: AppColors.red,
          textColor: Colors.white,
        );
      };
}
