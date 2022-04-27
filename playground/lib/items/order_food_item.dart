import 'package:flutter/material.dart';
import 'classes/food_item.dart';

class OrderFoodItem extends StatelessWidget {
  const OrderFoodItem({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    Container cartItemImage = Container(
      padding: const EdgeInsets.all(8.0),
      width: 120,
      height: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(foodItem.imagePath),
          )),
    );
    final Text cartItemName = Text(foodItem.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
    final Text cartItemPrice = Text('${foodItem.price}₸',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
    final Text cartItemQuantity = Text(
      'x${foodItem.quantity}',
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontFamily: 'Nunito'),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.15),
      ),
      height: 100,
      child: Row(
        children: [
          cartItemImage,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cartItemName,
                cartItemPrice,
                cartItemQuantity,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
