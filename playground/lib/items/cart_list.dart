import 'package:flutter/material.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';
import 'cart_food_item.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key, required this.screenSize}) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCart>(
      builder: (context, cartList, child) {
        const _yourCartEmptyText = Align(
          alignment: Alignment.center,
          child: Text(
            'Ваш Список пуст :(',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
          ),
        );
        var _cartItemList = Scrollbar(
          radius: const Radius.circular(30),
          isAlwaysShown: true,
          child: ListView.builder(
            itemCount: cartList.getList().length,
            itemBuilder: (BuildContext cntxt, int index) =>
                CartFoodItem(foodItem: cartList.getList()[index]),
          ),
        );
        return Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          padding: const EdgeInsets.all(8),
          width: screenSize.width,
          height: screenSize.height * .6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45),
          ),
          child: (cartList.getList().isEmpty == true)
              ? _yourCartEmptyText
              : _cartItemList,
        );
      },
    );
  }
}
