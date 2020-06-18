abstract class StringValidator {
  bool isNotValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isNotValid(String value) {
    return value.isEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator pswrdValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
