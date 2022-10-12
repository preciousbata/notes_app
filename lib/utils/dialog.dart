import 'package:flutter/material.dart';

Future<bool> showConfrimation(BuildContext context,
    {required String title,
    required String content}) async {
  bool shouldDismiss = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'cancel');
                shouldDismiss = false;
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, 'delete');
                  shouldDismiss = true;
                },
                child: const Text('DELETE'))
          ],
        )
      ],
    ),
  );
  return shouldDismiss;
}
