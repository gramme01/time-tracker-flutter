import 'package:meta/meta.dart';

import '../app/home/models/job.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  // Future<void> setJob(Job job);
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  String documentIdFromCurrentDate = DateTime.now().toIso8601String();

  final _service = FirestoreService.instance;
  @override
  Future<void> createJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, documentIdFromCurrentDate),
        data: job.toMap(),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: Job.fromMap,
      );
}
