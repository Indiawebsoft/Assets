import 'package:asset_management/assetmana//data/local/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs{

  static final AppSharedPrefs _repo = new AppSharedPrefs();
  static AppSharedPrefs get() => _repo;

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }


  Future<void> addValue(String preferenceKeys, String text) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setString(preferenceKeys, text);
  }
  
  
  // Future<void> addValue(PreferenceKeys preferenceKeys, String text) async {
  //   SharedPreferences prefs = await getSharedPrefs();
  //   await prefs.setString(preferenceKeys, text);
  // }

  Future<void> addBoolean(String preferenceKeys, bool value) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setBool(preferenceKeys, value);
  }

  Future<void> addInt(String preferenceKeys, int value) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setInt(preferenceKeys, value);
  }

  Future<String?> getValue(String preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getString(preferenceKeys);
  }

  Future<int?> getInt(String preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getInt(preferenceKeys);
  }

  Future<bool?> getBoolean(String preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getBool(preferenceKeys);
  }

  Future<bool> clearSharedPreference() async {
    SharedPreferences prefs = await getSharedPrefs();
    String? email = await getValue(PreferenceKeys.USER_EMAIL);
    String? password = await getValue(PreferenceKeys.USER_PASSWORD);
    // bool? firstTime = await getBoolean(PreferenceKeys.FIRST_TIME);
    await prefs.clear();
    await addValue(PreferenceKeys.USER_EMAIL, email!);
    await addValue(PreferenceKeys.USER_PASSWORD, password!);
    // await addBoolean(PreferenceKeys.FIRST_TIME, firstTime!);
    return true;
  }

  static Future<String?> getAccessToken() async {
    return await AppSharedPrefs.get().getValue(PreferenceKeys.ACCESS_TOKEN);
  }

}