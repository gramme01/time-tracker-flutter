import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpingSignInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(
            builder: (context) => SignInPage.create(context),
          ),
        ),
      ),
    );
  }
}
