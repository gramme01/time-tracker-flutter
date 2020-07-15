import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/avatar.dart';

import '../../../common_widgets/platform_alert_dialog.dart';
import '../../../services/auth.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signout(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
            title: 'Logout',
            content: 'Are you sure you want to logout',
            noActionText: 'Cancel',
            yesActionText: 'Logout')
        .show(context);

    if (didRequestSignOut) _signout(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(130), child: _buildUserInfo(user)),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          radius: 50,
          photoUrl: user.photoUrl,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(user.displayName, style: TextStyle(color: Colors.white)),
        SizedBox(height: 8),
      ],
    );
  }
}
