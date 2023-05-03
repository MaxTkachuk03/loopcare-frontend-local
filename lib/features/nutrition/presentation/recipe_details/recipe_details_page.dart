import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Greek salad',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
              background: FlutterLogo(),
            ),
          ),
        ],
      ),
    );
  }
}
