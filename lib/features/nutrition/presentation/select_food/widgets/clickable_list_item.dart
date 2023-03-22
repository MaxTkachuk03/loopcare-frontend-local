import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_blue.dart';

class ClickableListItem extends StatelessWidget {
  final String title;
  final String description;

  const ClickableListItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 18.0,
                    height: 24.0,
                    child: CheckboxBlue(
                      value: true,
                      onChanged: _onChanged,
                    ),
                  ),
                  const SizedBox(
                    width: 14.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: AppColors.greyLabel,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const ImageIcon(
              AppIcons.arrow,
              color: AppColors.greyLabel,
            )
          ],
        ),
      ),
    );
  }

  void _onChanged(bool? value) {}

  _onTap(BuildContext context) {
    context.router.push(SelectServingRoute(
        foodItemId: '38225',
        initialServingId: '37553',
        foodItemName: 'Black Beans'));
  }
}
