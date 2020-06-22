import 'package:flutter/foundation.dart';
import 'package:time_tracker/services/auth.dart';

import 'email_sign_in_model.dart';
import 'validators.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool hasSubmitted;
  final AuthBase auth;

  EmailSignInChangeModel({
    @required this.auth,
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

  void updateEmail(String email) => updateWith(email: email);
  void updatePswrd(String password) => updateWith(password: password);

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      hasSubmitted: false,
      isLoading: false,
    );
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool hasSubmitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.hasSubmitted = hasSubmitted ?? this.hasSubmitted;
    notifyListeners();
  }

  Future<void> submit() async {
    updateWith(hasSubmitted: true, isLoading: true);
    try {
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        await auth.createUserWithEmailAndPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
