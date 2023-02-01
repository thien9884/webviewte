import 'package:flutter/material.dart';

class AlertUtils {
  static displayErrorAlert(BuildContext context, String message) {
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: const Text('Error'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      );
    });
  }
}