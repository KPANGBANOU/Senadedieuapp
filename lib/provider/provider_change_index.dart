// ignore_for_file: non_constant_identifier_names, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';

class ProviderChangeIndex with ChangeNotifier {
  PageController _pageController = PageController(initialPage: 0);

  int _current_index = 0;
  int get current_index {
    return _current_index;
  }

  PageController get page {
    return _pageController;
  }

  void change_current_index(int? index) {
    _current_index = index!;
    notifyListeners();
  }
}
