import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Job {
  final String id;
  final String name;
  final int ratePerHour;
  Job({
    @required this.id,
    @required this.name,
    @required this.ratePerHour,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  static Job fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;
    if (map['name'] == null) return null;
    return Job(
      id: documentId,
      name: map['name'],
      ratePerHour: map['ratePerHour'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  // int get hashCode => hashValues(id, name, ratePerHour);
  int get hashCode => id.hashCode ^ name.hashCode ^ ratePerHour.hashCode;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Job &&
        o.id == id &&
        o.name == name &&
        o.ratePerHour == ratePerHour;
  }

  @override
  String toString() => 'Job(id: $id, name: $name, ratePerHour: $ratePerHour)';
}
