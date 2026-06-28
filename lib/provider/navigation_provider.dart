import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  void updateIndex (int updatedIndex) {
    currentIndex = updatedIndex;
    notifyListeners();
  }
}