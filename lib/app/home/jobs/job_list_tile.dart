import 'package:flutter/material.dart';

import '../models/job.dart';

class JobListTile extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  const JobListTile({Key key, @required this.job, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
