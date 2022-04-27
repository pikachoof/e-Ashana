import 'package:flutter/material.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'package:playground/screens/payment_page.dart';
import 'cart_list.dart';
import 'package:provider/provider.dart';

class CartFoodList extends StatelessWidget {
  const CartFoodList({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    ShoppingCart cartList = Provider.of<ShoppingCart>(context, listen: false);
    const dividerLine = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        thickness: 1,
        indent: 5,
        color: Colors.black,
      ),
    );
    var totalPriceText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<ShoppingCart>(
        builder: (context, foo, child) => Text(
          'Сумма: ${foo.totalPrice()}₸',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
    final clearCartButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        widget: const Icon(Icons.delete_rounded, size: 42),
        onTap: (context) => () => cartList.removeAll(),
        someContext: context,
      ),
    );
    final paymentButton = InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PaymentPage(orderList: cartList),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.redAccent,
            gradient:
                const LinearGradient(colors: [Colors.redAccent, Colors.orange]),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 5,
                blurRadius: 5,
              ),
            ],
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'К оплате!',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ),
    );
    final cartBody = CartList(screenSize: screenSize);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cartBody,
        dividerLine,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            totalPriceText,
            clearCartButton,
          ],
        ),
        paymentButton,
      ],
    );
  }
}
