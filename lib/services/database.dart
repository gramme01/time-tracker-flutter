import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker/services/api_path.dart';

import '../app/home/models/job.dart';

abstract class Database {
  // Future<void> setJob(Job job);
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async => await _setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final documentReference = Firestore.instance.document(path);
    print('$path: $data');
    await documentReference.setData(data);
  }
}
