import 'package:flutter/material.dart';
import 'package:time_tracker/app/home/jobs/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  const ListItemsBuilder({
    Key key,
    this.snapshot,
    this.itemBuilder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        // TODO: return ListVIew
      } else {
        return EmptyContent();
      }
    }
    return Container();
  }
}
