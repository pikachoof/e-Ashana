import 'package:playground/items/classes/food_item.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier {
  List<FoodItem> _items = [];

  List<FoodItem> getList() {
    return _items;
  }

  int totalPrice() {
    int total = 0;
    for (int i = 0; i < _items.length; i++) {
      total += _items[i].price * _items[i].quantity;
    }
    return total;
  }

  void add(FoodItem item) {
    int index = _items.indexOf(item);
    if (index == -1) {
      item.quantity = 1;
      _items.add(item);
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void decrement(FoodItem item) {
    int index = _items.indexOf(item);
    if (index == -1) return;
    _items[index].quantity--;
    if (_items[index].quantity == 0) {
      _items.remove(item);
      item.quantity = 0;
    }
    notifyListeners();
  }

  void delete(FoodItem item) {
    _items.remove(item);
    item.quantity = 0;
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
