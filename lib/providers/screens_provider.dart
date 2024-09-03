import 'package:flutter/material.dart';

class ScreensProvider with ChangeNotifier {
  int _currentScreenIndex = 0;

  int getCurrentScreenIndex() => _currentScreenIndex;

  void setCurrentScreenIndex(int index) {
    _currentScreenIndex = index;
    notifyListeners();
  }
}
