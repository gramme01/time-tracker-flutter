import 'validators.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInModel with EmailAndPasswordValidators {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool hasSubmitted;

  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.hasSubmitted = false,
  });

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        pswrdValidator.isValid(password) &&
        !isLoading;
  }

  String get emailErrorText {
    bool shouldShowEmailErrorText =
        hasSubmitted && emailValidator.isNotValid(email);
    return shouldShowEmailErrorText ? invalidEmailErrorText : null;
  }

  String get passwordErrorText {
    bool shouldShowPasswordErrorText =
        hasSubmitted && pswrdValidator.isNotValid(password);
    return shouldShowPasswordErrorText ? invalidPasswordErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool hasSubmitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      hasSubmitted: hasSubmitted ?? this.hasSubmitted,
    );
  }
}
