import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, dynamic value}) async
  {
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is List<String>) return await sharedPreferences!.setStringList(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({required String key})
  {
    return sharedPreferences!.get(key);
  }

  static List<String>? getCartItems({required String key})
  {
    return sharedPreferences!.getStringList(key);
  }

  static Future<bool> removeKey({required String key}) async
  {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> removeAllSharedData() async
  {
    return await sharedPreferences!.clear();
  }

}
