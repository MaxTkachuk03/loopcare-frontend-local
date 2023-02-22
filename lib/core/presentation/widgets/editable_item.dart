import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EditableItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String routeName;

  const EditableItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(22.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.bgGreen,
                blurRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      subtitle ?? '',
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              InkWell(
                onTap: () => _onEditTap(context),
                child: const Image(
                  image: AppImages.editButton,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2.0,
        )
      ],
    );
  }

  void _onEditTap(BuildContext context) {
    context.router.popUntilRouteWithName(routeName);
  }
}
