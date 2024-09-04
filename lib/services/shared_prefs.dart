import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._internal();
  static SharedPrefs instance = SharedPrefs._internal();
  factory SharedPrefs() => instance;

  final String loginFlagKey = 'user-logged-in';

  Future<void> setLoginFlag() async {
    try {
      final sharedPrefrence = await SharedPreferences.getInstance();
      sharedPrefrence.setBool(loginFlagKey, true);
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  Future<bool?> getLoginFlag() async {
    final sharedPrefrence = await SharedPreferences.getInstance();
    return sharedPrefrence.getBool(loginFlagKey);
  }
}
