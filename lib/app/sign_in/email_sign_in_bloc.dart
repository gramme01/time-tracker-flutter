import 'dart:async';

import 'email_sign_in_model.dart';

class EmailSignInBloc {
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith(
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool hasSubmitted,
  ) {
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
}
