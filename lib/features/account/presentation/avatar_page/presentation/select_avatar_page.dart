import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/image_helper/image_helper.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/user_avatar.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/avatar_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/domain/user_avatar_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatar_menu.dart';
import 'package:loopcare_frontend/features/account/presentation/avatar_page/presentation/widgets/avatars_list.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SelectAvatarPage extends StatefulWidget {
  final void Function()? onDispose;

  const SelectAvatarPage({super.key, this.onDispose});

  @override
  State<SelectAvatarPage> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState extends State<SelectAvatarPage> {
  late final AvatarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AvatarController(
      ImageHelper(),
      riverBloc: context.read<RiverBloc>(),
    );

    final mode = context.read<AuthenticationBloc>().state.data.hasAvatar
        ? const UserAvatarMode.network()
        : const UserAvatarMode.local();

    _controller.showSizeError.addListener(_sizeErrorListener);
    _controller.showPermissionsPopup.addListener(_permissionsListener);

    _controller.setAvatarMode(mode);
  }

  void _sizeErrorListener() {
    if (!_controller.showSizeError.value) return;

    ModalBottomSheet.avatarSizeErrorDialog(
      context: context,
      onClose: () => _controller.showSizeError.value = false,
    );
  }

  void _permissionsListener() {
    if (!_controller.showPermissionsPopup.value) return;

    ModalBottomSheet.galeryPermissonsDialog(
      context: context,
      onGoToSettings: openAppSettings,
      onClose: () => _controller.showPermissionsPopup.value = false,
    );
  }

  void _onSaveAvatarPressedHandler() async {
    final avatar = _controller.selectedAvatar.value;
    final photo = _controller.selectedPhoto.value;

    if (avatar == null && photo == null) return;

    late MultipartFile multipartFile;

    if (avatar != null) {
      multipartFile = await ImageHelper.createMultipartFromAsset(avatar.imagePath);
    }

    if (photo != null) {
      multipartFile = await ImageHelper.createMultipartFromFile(photo);
    }

    final FormData data = FormData.fromMap({'avatar': multipartFile});

    _controller.changeShowAvatarMenu(false);

    if (mounted) {
      context.read<AuthenticationBloc>().add(AuthenticationEvent.uploadAvatar(data));
    }
  }

  void _onErrorUploadAvatar(AuthenticationState s) {
    context.showError(content: CustomText(s.data.error?.message ?? ''));
  }

  void _onAvatarUploaded(_) {
    _controller.finishRiverModuleItem(complete: true);
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  void _avatarUpdateListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(error: _onErrorUploadAvatar, avatarUploaded: _onAvatarUploaded);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        leading: CustomFilledIconButton.leadingBlueLighter(),
        title: LocalizedTexts.avatarAvatar.tr(),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: _avatarUpdateListener,
        child: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Stack(
                    children: [
                      AccountContainer(
                        child: Column(
                          children: [
                            CustomText.bitter600(
                              LocalizedTexts.avatarSelectProfilePicture.tr(),
                              style: context.textTheme.headlineSmall,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 17.0),
                              child: Center(
                                child: UserAvatar(onPressed: null, controller: _controller),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _controller.showAvatarMenu,
                              builder: (context, showMenu, _) {
                                if (!showMenu) return const SizedBox.shrink();

                                return AvatarMenu(controller: _controller);
                              },
                            ),
                            const Divider(height: 34.0, thickness: 1, color: AppColors.blueLighter),
                            CustomText.w400(
                              LocalizedTexts.avatarChooseYourAvatar.tr(),
                              style: context.textTheme.bodyMedium,
                            ),
                            AvatarsList(controller: _controller),
                            const SizedBox(height: 12),
                            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, state) {
                                final isLoading = state is AuthenticationStateIsLoading;

                                return ValueListenableBuilder(
                                  valueListenable: _controller.canSave,
                                  builder: (_, canSave, __) => CustomElevatedButton.blueFullWidth(
                                    label: LocalizedTexts.save.tr(),
                                    onPressed: canSave ? _onSaveAvatarPressedHandler : null,
                                    isLoading: isLoading,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: _controller.pickingImageInProgress,
                          builder: (context, inProgress, _) {
                            return inProgress
                                ? Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueLighter.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Loader(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.finishRiverModuleItem();
    _controller.showSizeError.removeListener(_sizeErrorListener);
    _controller.showPermissionsPopup.removeListener(_permissionsListener);
    _controller.dispose();
    super.dispose();
  }
}
