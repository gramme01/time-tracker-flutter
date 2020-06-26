import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/database.dart';

import '../services/auth.dart';
import './home/jobs/jobs_page.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) return SignInPage.create(context);
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child: JobsPage(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
