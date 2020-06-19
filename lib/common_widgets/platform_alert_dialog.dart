import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String noActionText;
  final String yesActionText;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.noActionText,
    @required this.yesActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(yesActionText != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];

    if (noActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(noActionText),
          onPressed: () => Navigator.pop(context, false),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(yesActionText),
        onPressed: () => Navigator.pop(context, true),
      ),
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({
    @required this.child,
    @required this.onPressed,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext contexntext) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
