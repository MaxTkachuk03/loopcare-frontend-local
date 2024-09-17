import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class BuddyInvitationPending extends StatelessWidget {
  const BuddyInvitationPending({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.bitter600(
            LocalizedTexts.buddyPendingTitle.tr(),
            style: context.textTheme.headlineSmall,
          ),
          BlocBuilder<BuddyBloc, BuddyState>(
            builder: (context, state) {
              final date = _getDate(state.data.buddy?.invitation?.invitationDate);
              return CustomText.w400(
                LocalizedTexts.buddyPendingSubTitle.tr(
                  {
                    if (date != null) 'date': '${date.weekdayString} ${date.shortDateWithYear}',
                    if (date != null) 'time': date.timeHoursMinutes
                  },
                ),
                style: context.textTheme.bodyMedium,
              );
            },
          ),
          const SizedBox(height: 18.0),
          CustomOutlinedButton.blueFullWidth(
            onPressed: () {
              context.read<BuddyBloc>().add(const BuddyEvent.resendInvitation());
            },
            label: LocalizedTexts.buddyResendInvitation.tr(),
          ),
        ],
      ),
    );
  }

  DateTime? _getDate(DateTime? timeStamp) {
    if (timeStamp == null) {
      return null;
    }
    return timeStamp.toLocal();
  }
}
