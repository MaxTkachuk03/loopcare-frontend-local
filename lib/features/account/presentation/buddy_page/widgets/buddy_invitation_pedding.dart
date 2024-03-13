import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';

class BuddyInvitationPending extends StatefulWidget {
  const BuddyInvitationPending({super.key});

  @override
  State<BuddyInvitationPending> createState() => _BuddyInvitationPendingState();
}

class _BuddyInvitationPendingState extends State<BuddyInvitationPending> {
  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  namedArgs: {
                    if (date != null) 'date': '${date.weekdayString} ${date.shortDateWithYear}',
                    if (date != null) 'time': date.timeHoursMinutes
                  },
                ),
                style: context.textTheme.bodyMedium,
              );
            },
          ),
          const SizedBox(height: 17.0),
          CustomOutlinedButton.blueFullWidth(
            onPressed: () {
              context.read<BuddyBloc>().add(const BuddyEvent.resendInvitation());
            },
            label: LocalizedTexts.buddyResendInvitation.tr(),
          ),
          const SizedBox(height: 17.0),
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
