import 'package:flutter/material.dart';
import 'package:playground/items/classes/order_item.dart';

class OrderController extends ChangeNotifier {
  final List<OrderItem> _orders = [];

  get getOrders => _orders;

  void addOrder(OrderItem item) {
    _orders.add(item);
  }
}
