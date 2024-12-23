import 'dart:ui';

import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  Map<String, Color> _currentTheme;

  ThemeProvider(this._currentTheme);

  // * Getternya jangan lupa bang
  Map<String, Color> get currentTheme => _currentTheme;

  void setTheme(Map<String, Color> theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
