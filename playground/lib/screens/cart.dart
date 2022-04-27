import 'package:flutter/material.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'package:playground/items/cart_food_list.dart';
import 'package:playground/main.dart';

class CartPageBody extends StatelessWidget {
  const CartPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    const yourCartText = Text(
      'Ваша Корзина',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
    );
    final returnButton = CustomButton(
      widget: const Icon(Icons.arrow_left_rounded, size: 42),
      onTap: (context) => () => Navigator.pop(context),
      someContext: context,
    );
    final homeButton = CustomButton(
      widget: const Icon(Icons.home_rounded, size: 42),
      onTap: (context) => () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainMenu(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var tween = Tween<Offset>(
                        begin: const Offset(-1.0, 0), end: Offset.zero)
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

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // The upper menu bar
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                returnButton,
                yourCartText,
                homeButton,
              ],
            ),
          ),
          // The lower part of the screen with the cartList, e.t.c
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                color: Colors.white),
            height: screenSize.height * .9,
            child: CartFoodList(screenSize: screenSize),
          ),
        ],
      ),
    );
  }
}
