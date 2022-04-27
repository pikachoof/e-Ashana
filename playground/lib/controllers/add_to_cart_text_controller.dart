import 'package:flutter/foundation.dart';

class AddToCartText extends ChangeNotifier {
  String text = 'В корзину!';

  String get getText => text;

  void setText(String newText) {
    text = newText;
    notifyListeners();
  }
}
