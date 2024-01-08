import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  getSetting(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(name);
    return boolValue;
  }

  updateSetting(String name, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(name, value);
  }

  setInt(String name,int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(name, value);
  }

  getInt(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(name);
    return value;
  }

}
