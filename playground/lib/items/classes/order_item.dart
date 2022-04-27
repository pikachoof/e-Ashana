import 'package:playground/items/classes/food_item.dart';

class OrderItem {
  final int number;
  final int totalItemCount;
  final int totalPrice;
  List<FoodItem> orderItems;
  final String pickupLocation;
  OrderItem(
      {required this.number,
      required this.totalItemCount,
      required this.totalPrice,
      required this.orderItems,
      required this.pickupLocation});
}
