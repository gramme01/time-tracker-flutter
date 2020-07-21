import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_model.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  test(
    'WHEN email is updated '
    'AND password is updated '
    'AND submit is called '
    'THEN modelStream emits the correct events',
    () async {
      when(mockAuth.signInWithEmailAndPassword(any, any)).thenThrow(
          PlatformException(code: 'ERROR', message: 'Error Signing In'));
      String sampleEmail = 'email@email.com';
      String samplePassword = '123456';

      expect(
        bloc.modelStream,
        emitsInOrder([
          EmailSignInModel(),
          EmailSignInModel(email: sampleEmail),
          EmailSignInModel(
            email: sampleEmail,
            password: samplePassword,
          ),
          EmailSignInModel(
            email: sampleEmail,
            password: samplePassword,
            hasSubmitted: true,
            isLoading: true,
          ),
          EmailSignInModel(
            email: sampleEmail,
            password: samplePassword,
            hasSubmitted: true,
            isLoading: false,
          ),
        ]),
      );

      bloc.updateEmail(sampleEmail);
      bloc.updatePswrd(samplePassword);
      try {
        await bloc.submit();
      } catch (e) {}
    },
  );
}
