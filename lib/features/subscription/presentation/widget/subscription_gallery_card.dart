import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionGalleryCard extends StatelessWidget {
  final String? url;
  final String? title;
  final String? label;

  const SubscriptionGalleryCard({
    super.key,
    this.title,
    this.label,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            image: url != null
                ? DecorationImage(
                    image: CachedNetworkImageProvider(url!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            border: Border.all(
              color: AppColors.blueLighter,
              width: 2,
            ),
            gradient: const LinearGradient(
                colors: [AppColors.blueDarker, AppColors.transparent],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                stops: [0.15, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0), color: AppColors.petrolRegular),
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                  child: CustomText.w600(
                    label ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: ThemeConstants.fontSize10,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                CustomText.bitter600(
                  title ?? '',
                  textAlign: TextAlign.start,
                  style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
