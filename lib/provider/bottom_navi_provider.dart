import 'package:flutter/foundation.dart';

class BottomNaviProvider with ChangeNotifier {
  int _bottomNaviIndex = 0;
  get bottomNaviIndex => _bottomNaviIndex;
  void changeBottomNaviIndex(int index) {
    if (_bottomNaviIndex != index) {
      _bottomNaviIndex = index;
      notifyListeners();
    }
  }
}
