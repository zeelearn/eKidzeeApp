import 'package:flutter/material.dart';

class Utility{


  static void showMessage(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  static void showMessages(BuildContext context,String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message!),
    ));
  }

  static void displaySnackbar(BuildContext context,
      {String msg = "Feature is under development",
        required GlobalKey<ScaffoldState> key}) {
    final snackBar = SnackBar(content: Text(msg));
    if (key != null && key.currentState != null) {
      key.currentState?.hideCurrentSnackBar();
      key.currentState?.showSnackBar(snackBar);
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

// static launchOnWeb(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   }
// }


}