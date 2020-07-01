import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/jobs/empty_content.dart';

import '../../../common_widgets/platform_alert_dialog.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';
import '../models/job.dart';
import 'edit_job_page.dart';
import 'job_list_tile.dart';

class JobsPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          if (jobs.isNotEmpty) {
            final children = jobs
                .map((job) => JobListTile(
                      job: job,
                      onTap: () => EditJobPage.show(context, job: job),
                    ))
                .toList();
            return ListView(
              children: children,
            );
          } else {
            return EmptyContent();
          }
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Unable to load job feed'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
