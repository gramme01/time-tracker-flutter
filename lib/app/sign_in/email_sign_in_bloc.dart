import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../../services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInBloc {
  final AuthBase auth;
  final _modelSubject =
      BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());

  EmailSignInBloc({@required this.auth});

  ValueStream<EmailSignInModel> get modelStream => _modelSubject.stream;

  EmailSignInModel get _model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePswrd(String password) => updateWith(password: password);
  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
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
    // update model
    _modelSubject.value = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      hasSubmitted: hasSubmitted,
    );
  }

  Future<void> submit() async {
    updateWith(hasSubmitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
