import 'package:flutter/cupertino.dart';

class PGController extends ChangeNotifier {
  int currentPageIndex = 0;

  void getPageIndex() => currentPageIndex;

  void setPageIndex(int newPageIndex) {
    currentPageIndex = newPageIndex;
    notifyListeners();
  }
}
