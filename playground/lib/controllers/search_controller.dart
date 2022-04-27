import 'package:flutter/material.dart';

class SearchController extends ChangeNotifier {
  bool isSearching = false;

  void changeSearchingState() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void setSearchState(bool value) => isSearching = value;
}
