import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/image_helper/image_helper.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/user_avatar.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatar_variants_list.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatars_list.dart';

@RoutePage()
class SelectAvatarPage extends StatefulWidget {
  const SelectAvatarPage({super.key});

  @override
  State<SelectAvatarPage> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState extends State<SelectAvatarPage> {
  final AvatarController _controller = AvatarController(ImageHelper());

  void _onSaveAvatarPressedHandler() {}

  void _onAddPhotoPressedHandler() {}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        leading: CustomFilledIconButton.leadingBlueLighter(),
        title: LocalizedTexts.avatar.tr(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: AccountContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.selectProfilePicture.tr(),
                      style: context.textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: Center(
                        child: ValueListenableBuilder(
                          valueListenable: _controller.selectedAvatar,
                          builder: (context, avatar, _) => ValueListenableBuilder(
                            valueListenable: _controller.selectedPhoto,
                            builder: (context, photo, _) => UserAvatar(
                              avatar: avatar,
                              photo: photo,
                              onPressed: null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        CustomOutlinedButton.blueFullWidth(
                          label: LocalizedTexts.addPhoto.tr(),
                          onPressed: _onAddPhotoPressedHandler,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _controller.showAvatarVariations,
                          builder: (context, showVariations, _) {
                            if (!showVariations) return const SizedBox.shrink();

                            return AvatarVariantsList(controller: _controller);
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 34.0, thickness: 1, color: AppColors.blueLighter),
                    CustomText.w400(
                      LocalizedTexts.chooseYourAvatar.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    AvatarsList(controller: _controller),
                    const SizedBox(height: 12),
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.save.tr(),
                      onPressed: _onSaveAvatarPressedHandler,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
