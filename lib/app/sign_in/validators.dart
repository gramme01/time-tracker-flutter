abstract class StringValidator {
  bool isNotValid(String value);
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isNotValid(String value) {
    return value.isEmpty;
  }

  @override
  bool isValid(String value) {
    if (value == null) return false;
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator pswrdValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
