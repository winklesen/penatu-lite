import 'package:flutter/material.dart';

void dialog(BuildContext context, String title, String subtitle, bool isDismiss,
    void Function() onPressed) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  });
}
