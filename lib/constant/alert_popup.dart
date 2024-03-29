import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertUtils {
  static displayErrorAlert(BuildContext context, String message,
      {VoidCallback? onPress}) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Thông báo'),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(message),
            ),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDestructiveAction: false,
                onPressed: onPress ??
                    () {
                      Navigator.pop(context);
                    },
                child: const Text('Đồng ý'),
              ),
            ],
          );
        });
  }
}
