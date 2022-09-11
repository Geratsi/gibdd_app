
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static set(String name, String data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(name, data);
  }
  static setInt(String name, int data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(name, data);
  }
  static Future<String?> get(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(name);
  }
  static Future<int?> getInt(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(name);
  }
  static remove(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(name);
  }
}