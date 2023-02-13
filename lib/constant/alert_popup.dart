import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertUtils {
  static displayErrorAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }
}
