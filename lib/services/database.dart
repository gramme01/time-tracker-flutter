import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker/services/api_path.dart';

import '../app/home/models/job.dart';

abstract class Database {
  // Future<void> setJob(Job job);
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async => await _setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  @override
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (event) => event.documents
          .map(
            (snapshot) => Job(
              name: snapshot.data['name'],
              ratePerHour: snapshot.data['ratePerHour'],
            ),
          )
          .toList(),
    );
  }

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    await reference.setData(data);
  }
}
