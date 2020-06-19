import 'package:flutter/material.dart';

import 'auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;
  AuthProvider({@required this.auth, @required this.child});

  // TODO: implement updateShouldNotify
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType(aspect: AuthProvider);
    return provider.auth;
  }
}
