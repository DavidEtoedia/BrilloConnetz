import 'package:brillo_connetz/presentation/utils/dialog/basic_dialog_action.dart';
import 'package:brillo_connetz/presentation/utils/dialog/basic_dialog_alert.dart';
import 'package:brillo_connetz/presentation/utils/dialog/platform_dialog.dart';
import 'package:flutter/material.dart';

class ScreenAlertView {
  static showErrorDialog(
      {required BuildContext context, String errorText = ""}) {
    showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
              title: Text("Error",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      height: 1.5)),
              content: Text(errorText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5)),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  static showInfoDialog({required BuildContext context, String info = ""}) {
    showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
              title: Text("Error",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      height: 1.5)),
              content: Text(info,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.5)),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
