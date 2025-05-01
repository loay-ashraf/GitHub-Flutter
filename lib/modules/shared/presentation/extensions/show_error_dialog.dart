import 'package:flutter/material.dart';

extension ShowErrorDialog on Widget {
  void showErrorDialog({
    required BuildContext context,
    String title = 'Sorry!',
    required String message,
    String? detailsMessage,
    String primaryTitle = '',
    String secondaryTitle = '',
    VoidCallback? onPrimary,
    VoidCallback? onSecondary,
  }) {
    Widget makeDialogContents() {
      if (detailsMessage != null) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              width: 275,
              child: ExpansionTile(
                title: const Text('Tap to see details'),
                children: <Widget>[
                  ListTile(
                    title: SelectableText(detailsMessage),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Text(message);
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: makeDialogContents(),
          actions: [
            TextButton(
              onPressed: () {
                if (onSecondary != null) {
                  onSecondary();
                }
                Navigator.of(context).pop();
              },
              child: Text(secondaryTitle),
            ),
            ElevatedButton(
              onPressed: () {
                if (onPrimary != null) {
                  onPrimary();
                }
                Navigator.of(context).pop();
              },
              child: Text(primaryTitle),
            ),
          ],
        );
      },
    );
  }
}
