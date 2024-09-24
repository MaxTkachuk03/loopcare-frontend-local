import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
