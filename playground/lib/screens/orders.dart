import 'package:flutter/material.dart';
import 'package:playground/controllers/order_controller.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'package:playground/items/classes/order_item.dart';
import 'package:playground/main.dart';
import 'package:playground/screens/order_list_item.dart';
import 'package:provider/provider.dart';

class OrderPageBody extends StatelessWidget {
  const OrderPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OrderItem> orderList =
        context.watch<OrderController>().getOrders;
    final screenSize = MediaQuery.of(context).size;

    const _yourOrderListText = Text(
      'Ваши Заказы',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
    );
    final _returnButton = CustomButton(
      widget: const Icon(Icons.arrow_left_rounded, size: 42),
      onTap: (context) => () => Navigator.pop(context),
      someContext: context,
    );
    final _homeButton = CustomButton(
      widget: const Icon(Icons.home_rounded, size: 42),
      onTap: (context) => () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainMenu(),
              transitionsBuilder: (_, animation, __, child) {
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
    var _orderList = ListView.builder(
      itemCount: orderList.length,
      itemBuilder: (_, int index) =>
          OrderItemContainer(orderItem: orderList[index]),
    );
    var _orderListContainer = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45),
        ),
        color: Colors.white,
      ),
      height: screenSize.height * .9,
      child: Scrollbar(
        radius: const Radius.circular(30),
        child: _orderList,
      ),
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
                _returnButton,
                _yourOrderListText,
                _homeButton,
              ],
            ),
          ),
          // The lower part of the screen with the cartList, e.t.c
          _orderListContainer,
        ],
      ),
    );
  }
}

class OrderItemContainer extends StatelessWidget {
  const OrderItemContainer({Key? key, required this.orderItem})
      : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    var _orderText = Text(
      'Заказ #${orderItem.number}',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
    const _informationText = Text('Информация:');
    var _orderItemCountText = Text(
      'Кол-во продуктов: ${orderItem.totalItemCount}',
    );
    var _totalPriceText = Text('Сумма: ${orderItem.totalPrice}₸');
    var _orderDetailsButton = InkWell(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              OrderListItemBody(orderItem: orderItem),
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
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45), color: Colors.white),
        child: const Text(
          'Подробнее',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colors.grey.withOpacity(.15),
      ),
      child: Column(
        children: [
          _orderText,
          _informationText,
          _orderItemCountText,
          _totalPriceText,
          _orderDetailsButton,
        ],
      ),
    );
  }
}
