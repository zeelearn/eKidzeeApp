import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class Utility{


  // static Future<String> getDeviceIdentifier() async {
  //   String? deviceIdentifier = "unknown";
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     print("Android device Info");
  //     if(androidInfo==null){
  //       print("----NULL");
  //     }
  //     print("Android device Info ${androidInfo.androidId}");
  //     deviceIdentifier = androidInfo.androidId;
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     deviceIdentifier = iosInfo.identifierForVendor;
  //   } else if (kIsWeb) {
  //     // The web doesnt have a device UID, so use a combination fingerprint as an example
  //     WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
  //     String? userAgent = webInfo.userAgent;
  //     deviceIdentifier = "${webInfo.vendor} ${userAgent as String}";
  //   } else if (Platform.isLinux) {
  //     LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
  //     deviceIdentifier = linuxInfo.machineId;
  //   }
  //   return deviceIdentifier as String;
  // }

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


  static showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

// static launchOnWeb(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   }
// }


}