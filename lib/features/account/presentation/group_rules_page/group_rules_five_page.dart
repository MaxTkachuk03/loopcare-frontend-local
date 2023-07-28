import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class GroupRulesFivePage extends StatelessWidget {
  const GroupRulesFivePage({Key? key}) : super(key: key);

  void _onIAgreePressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupRulesSix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.router.pop,
        ),
        title: Text(
          LocalizedTexts.supportGroupPreferences,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ).tr(),
      ),
      body: SafeArea(
        child: MainContainer(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 28.0),
                    const Text(
                      LocalizedTexts.groupRulesAttencion,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ).tr(),
                    const SizedBox(height: 32.0),
                    BulletListItem(
                      text: const Text(
                        LocalizedTexts.groupRulesFiveParagraphOne,
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                      ).tr(),
                      bulletSign: '9.',
                      bulletSize: 21.0,
                    ),
                    const SizedBox(height: 32.0),
                    BulletListItem(
                      text: const Text(
                        LocalizedTexts.groupRulesFiveParagraphTwo,
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                      ).tr(),
                      bulletSign: '10.',
                      bulletSize: 21.0,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: () => _onIAgreePressHandler(context),
                      child: const Text(LocalizedTexts.yesIAgree).tr(),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
