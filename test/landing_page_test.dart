import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/home_page.dart';

import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  StreamController<User> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onAuthStateChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLangingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: LandingPage(),
        ),
      ),
    );
    await tester.pump();
  }

  void stubOnAuthStateChangeYields(Iterable<User> onAuthStateChanged) {
    onAuthStateChangedController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged)
        .thenAnswer((_) => onAuthStateChangedController.stream);
  }

  testWidgets('Stream Waiting', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([]);

    await pumpLangingPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Null User', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([null]);

    await pumpLangingPage(tester);
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('Non-null User', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([User(uid: 'abc')]);

    await pumpLangingPage(tester);
    expect(find.byType(Homepage), findsOneWidget);
  });
}
