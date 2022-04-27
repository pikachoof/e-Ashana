import 'package:flutter/material.dart';
import 'package:playground/items/buttons/add_to_cart_button.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'package:playground/items/classes/food_item.dart';
import 'package:playground/screens/cart.dart';
import 'dart:math';

class FoodItemPage extends StatelessWidget {
  const FoodItemPage({Key? key, required this.foodItem}) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Container foodItemImage = Container(
      padding: const EdgeInsets.all(16.0),
      child: Hero(
        tag: foodItem.name,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image(
            fit: BoxFit.fill,
            height: screenSize.height * .4,
            image: AssetImage(foodItem.imagePath),
          ),
        ),
      ),
    );
    Container foodItemDescription = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(foodItem.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              Text(
                foodItem.shortDescription,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('${foodItem.price}₸',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
        ],
      ),
    );
    Row foodItemRating = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 36),
        Text('${Random().nextInt(5)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      ],
    );
    Container foodItemLongDescription = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        foodItem.longDescription,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey,
            overflow: TextOverflow.ellipsis),
        maxLines: 4,
      ),
    );
    CustomButton returnButton = CustomButton(
      widget: const Icon(Icons.arrow_left_rounded, size: 42),
      onTap: (context) => () => Navigator.pop(context),
      someContext: context,
    );
    CustomButton toCartButton = CustomButton(
      widget: const Icon(Icons.shopping_cart_rounded, size: 42),
      onTap: (context) => () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CartPageBody(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var tween =
                    Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.ease));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          ),
      someContext: context,
    );
    AddToCartButton addToCartButton =
        AddToCartButton(foodItem: foodItem, screenSize: screenSize);

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  returnButton,
                  toCartButton,
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                  color: Colors.white),
              height: screenSize.height * .85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  foodItemImage,
                  foodItemDescription,
                  foodItemRating,
                  foodItemLongDescription,
                  addToCartButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
