import 'package:flutter/material.dart';
import 'package:talkhost/BLoCandLogic/Authentication/auth_state.dart';
import 'package:talkhost/Utilities/strings.dart';

void showAlertDialogOnAuthentication(BuildContext context, {String? error, String? title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? 'OOPS!!! Something went wrong'),
        content: Text(error ?? AuthState.errorString),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              AuthState.errorString = defaultErrorLine;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
