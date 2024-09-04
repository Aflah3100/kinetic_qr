import 'package:flutter/material.dart';

class CreateQrCodeScreenProvider with ChangeNotifier {
  int _screenIndex = 0;
  int _wifisecurityType = 0;

  int getScreenIndex() => _screenIndex;

  void setScreenIndex(int index) {
    _screenIndex = index;
    notifyListeners();
  }

  int getWifiSecurityType() => _wifisecurityType;
  void setWifiSecurityType(int index) {
    _wifisecurityType = index;
    notifyListeners();
  }
}
