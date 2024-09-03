import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class ZoomErrorMapper {
  static final String _defaultErrorText = LocalizedTexts.errorSomethingWentWrong.tr();

  static final Map<String, String> _errorsMap = {
    "ZoomVideoSDKError_Session_Already_In_Progress": LocalizedTexts.sessionIsInProgress.tr(),
    "ZoomVideoSDKError_Session_Join_Failed": LocalizedTexts.failedToJoinSession.tr(),
    "ZoomVideoSDKError_Session_Disconncting": LocalizedTexts.disconnectedFromSession.tr(),
  };

  ZoomErrorMapper();

  static getLocalizedErrorText(String error) {
    final errorText = _errorsMap[error];
    return errorText ?? _defaultErrorText;
  }
}
