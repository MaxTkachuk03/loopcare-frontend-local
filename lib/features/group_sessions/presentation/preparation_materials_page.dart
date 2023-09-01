import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';

class PreparationMaterialsPage extends StatelessWidget {
  final String content;

  const PreparationMaterialsPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        leading: const BackButtonHexagon(),
        title: LocalizedTexts.preparation.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              const SizedBox(
                height: 48.0,
              ),
              HtmlRenderer(
                content: content,
                textStyle: const TextStyle(fontSize: ThemeConstants.fontSize18),
              ),
              const SizedBox(
                height: 65.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
