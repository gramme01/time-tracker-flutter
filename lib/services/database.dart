import 'package:meta/meta.dart';

abstract class Database {
  // Future<void> setJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
}
