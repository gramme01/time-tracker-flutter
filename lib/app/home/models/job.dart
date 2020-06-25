import 'dart:convert';

import 'package:meta/meta.dart';

class Job {
  final String name;
  final int ratePerHour;
  Job({
    @required this.name,
    @required this.ratePerHour,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  static Job fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Job(
      name: map['name'],
      ratePerHour: map['ratePerHour'],
    );
  }

  String toJson() => json.encode(toMap());

  static Job fromJson(String source) => fromMap(json.decode(source));
}
