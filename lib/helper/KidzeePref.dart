import 'package:shared_preferences/shared_preferences.dart';

class KidzeePref {
  late SharedPreferences prefs;

  KidzeePref();
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  KidzeePref._internal();

  Future<SharedPreferences> getPref() async {
    // Obtain shared preferences.
    return await SharedPreferences.getInstance();
  }

  getString(String key)  {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  setString(String key, String value) async {
    // Save an String value to 'action' key.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
