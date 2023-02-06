import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/consent_confirmation/presentation/widgets/consent_confirmation_chips.dart';
import 'package:loopcare_frontend/features/consent_confirmation/presentation/widgets/have_to_ask.dart';

class ConsentConfirmationPage extends StatefulWidget {
  const ConsentConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConsentConfirmationPage> createState() =>
      _ConsentConfirmationPageState();
}

class _ConsentConfirmationPageState extends State<ConsentConfirmationPage> {
  bool isVisiblePopup = false;

  void _onChangedVisibility(bool value) {
    setState(() {
      isVisiblePopup = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.medicalFitness.tr()),
      ),
      body: SafeArea(
        bottom: isVisiblePopup ? false : true,
        child: ScrollableContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 36.0,
                    ),
                    Text(
                      LocalizedTexts.consentConfirmationTitle.tr(),
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                          ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      LocalizedTexts.consentConfirmationQuestion.tr(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ConsentConfirmationChips(
                      onSelectHaveToAskOption: _onChangedVisibility,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 36.0,
                  ),
                  isVisiblePopup
                      ? const HaveToAsk()
                      : MainContainer(
                          child: Column(
                            children: [
                              OutlinedButton(
                                onPressed: () => _onMorePressed(context),
                                child: Text(LocalizedTexts.moreInfo.tr()),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onMorePressed(BuildContext context) {
    ModalBottomSheet.consentConfirmationMoreInfo(context: context);
  }
}
