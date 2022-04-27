import 'package:flutter/material.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'classes/food_item.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';
import 'package:provider/provider.dart';

class CartFoodItem extends StatelessWidget {
  const CartFoodItem({
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
    Text cartItemName = Text(
      foodItem.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
    Text cartItemPrice = Text(
      '${foodItem.price}₸',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
    Text cartItemQuantity = Text(
      'x${foodItem.quantity}',
      style: TextStyle(
        color: Colors.grey.withOpacity(.5),
        fontSize: 18,
        fontFamily: 'Nunito',
      ),
    );
    CustomButton addButton = CustomButton(
      widget: const Icon(Icons.add, size: 25),
      someContext: context,
      onTap: (context) => () => context.read<ShoppingCart>().add(foodItem),
    );
    CustomButton removeButton = CustomButton(
      widget: const Icon(Icons.remove, size: 25),
      someContext: context,
      onTap: (context) =>
          () => context.read<ShoppingCart>().decrement(foodItem),
    );

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        context.read<ShoppingCart>().delete(foodItem);
      },
      child: Container(
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
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  addButton,
                  cartItemQuantity,
                  removeButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
