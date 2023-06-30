import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/green_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class NutritionDetailsPage extends StatelessWidget {
  const NutritionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenAppBar(
        title: 'Nutrition',
        subtitle: 'reflection 16 june 2023',
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: MainContainer(
          child: ScrollableContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                Text(
                  'Calorie density per meal type',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text('In the table you can see: '),
                const BulletListItem(
                  text: Text('Calorie density per meal this month'),
                  bulletSize: 18,
                ),
                const BulletListItem(
                  text: Text('Percent of calories each meal contributed toward your daily intake'),
                  bulletSize: 18,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Image(
                  image: AppImages.nutritionTable,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  color: const Color(0xFFF0FAFB),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Advice from our food expert',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                          'It looks like the calorie density of your diet is great! Your meals will help you naturally eat less and fight cravings.'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
