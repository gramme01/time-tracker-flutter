import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  final String title;
  final PlatformException exception;

  PlatformExceptionAlertDialog({@required this.title, @required this.exception})
      : super(
          title: title,
          content: _message(exception),
          yesActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'Password must be at least 6 characters',
    'ERROR_EMAIL_ALREADY_IN_USE':
        'This email has been registered already. Sign in instead',
    'ERROR_INVALID_EMAIL': 'Please enter a valid email',
    'ERROR_WRONG_PASSWORD': 'The password is incorrect. Try Again',
    'ERROR_USER_NOT_FOUND':
        'No record found. Verify email or Create an account instead',

    ///  * `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///  * `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
  };
}
