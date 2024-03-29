import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';

class BuddyInvitationApproved extends StatelessWidget {
  const BuddyInvitationApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuddyBloc, BuddyState>(
      listener: (context, state) => state.maybeMap(
        error: (state) => _errorListener,
        orElse: () => null,
      ),
      builder: (context, state) {
        return Column(
          children: [
            _DetailsSection(
              title: LocalizedTexts.buddyEmail,
              value: state.data.buddy?.email ?? '',
            ),
            const SizedBox(
              height: 14,
            ),
            _DetailsSection(
              title: LocalizedTexts.buddyUserName,
              value: state.data.buddy?.username ?? '',
            ),
            const SizedBox(
              height: 14,
            ),
            _DetailsSection(
              title: LocalizedTexts.buddySince,
              value: _getDate(state.data.buddy?.invitation?.invitationDate),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        );
      },
    );
  }
}

String? _getDate(DateTime? timeStamp) {
  if (timeStamp == null) {
    return null;
  }
  final date = timeStamp.toLocal();
  return DateFormat('dd MMM yyyy').format(date);
}

_errorListener(BuildContext context, SubscriptionState state) {
  final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
  context.showErrorBar(
    content: Text(errorMessage),
    position: FlashPosition.top,
  );
  context.router.pop();
}

class _DetailsSection extends StatelessWidget {
  final String title;
  final String? value;

  const _DetailsSection({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 109,
      child: Row(
        children: [
          Expanded(
            child: AccountContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.blueDarker,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  CustomText.w600(
                    value?.tr() ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: ThemeConstants.fontSize14,
                      color: AppColors.blueDarker,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
