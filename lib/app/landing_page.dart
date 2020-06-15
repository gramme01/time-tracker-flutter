import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'home_page.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  LandingPage({@required this.auth});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanged
        .listen((user) => print('User: ${user?.uid}'));
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: widget.auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          if (user == null)
            return SignInPage(
              onSignIn: _updateUser,
              auth: widget.auth,
            );
          return HomePage(
            onSignOut: () => _updateUser(null),
            auth: widget.auth,
          );
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
