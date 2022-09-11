
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> set(String name, String? data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (data==null){
      remove(name);
    } else {
      sp.setString(name, data);
    }
  }
  static Future<String?> get(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(name);
  }
  static Future<void> remove(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(name);
  }
}