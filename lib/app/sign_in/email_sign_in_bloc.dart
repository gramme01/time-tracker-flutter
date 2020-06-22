import 'dart:async';

import 'package:flutter/foundation.dart';
import '../../services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInBloc {
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  EmailSignInBloc({@required this.auth});

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
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
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      hasSubmitted: hasSubmitted,
    );
    // sink updated model to _modelController
    _modelController.add(_model);
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
