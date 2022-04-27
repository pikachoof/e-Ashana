import 'package:flutter/material.dart';
import 'package:playground/controllers/order_controller.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';
import 'package:playground/items/classes/not_yet_implemented.dart';
import 'package:playground/items/classes/order_item.dart';
import 'package:playground/items/order_food_item.dart';
import 'package:playground/screens/payment_success_screen.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key, required this.orderList}) : super(key: key);

  final ShoppingCart orderList;

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Оплата заказа',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
    const _yourOrderText = Padding(
      padding: EdgeInsets.only(top: 16, left: 16),
      child: Text(
        'Ваш заказ',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    var _orderItemCount = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Кол-во продуктов: ${orderList.getList().length}',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
    var _totalOrderPrice = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Итог: ${orderList.totalPrice()}₸',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
    var _orderList = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(8),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.15),
      ),
      child: ListView.builder(
        itemCount: orderList.getList().length,
        itemBuilder: (context, index) => OrderFoodItem(
          foodItem: orderList.getList()[index],
        ),
      ),
    );
    var _pickupPointContainer = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      //height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.only(left: 8),
            child: const Text(
              'Пункт выдачи',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: const [
                Icon(Icons.gps_fixed_rounded),
                SizedBox(width: 8),
                Text(
                  'Столовая',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    var _paymentMethodContainer = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      //height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.only(left: 8),
            child: const Text(
              'Способ Оплаты',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: const [
                Icon(Icons.payment_rounded),
                SizedBox(width: 8),
                Text(
                  'Карта: ****4589',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            radius: 5,
            onTap: () {
              notYetImplemented(context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.only(left: 4),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.withOpacity(.2),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Добавить карту',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.add_rounded),
                  ]),
            ),
          ),
        ],
      ),
    );
    var _orderValidationButton = InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Подтверждение заказа',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Вы подтверждаете свой заказ?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<OrderController>().addOrder(
                      OrderItem(
                        number:
                            context.read<OrderController>().getOrders.length,
                        totalItemCount: orderList.getList().length,
                        totalPrice: orderList.totalPrice(),
                        orderItems: orderList.getList(),
                        pickupLocation: 'Столовая',
                      ),
                    );
                context.read<ShoppingCart>().removeAll();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessPage(),
                  ),
                );
              },
              child: const Text(
                'Да',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Нет',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              color: Colors.grey.withOpacity(.6),
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
            ],
          ),
        ),
        child: const Text(
          'Подтвердить заказ!',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _yourOrderText,
                    _orderItemCount,
                    _totalOrderPrice,
                    _orderList,
                    _pickupPointContainer,
                    _paymentMethodContainer,
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
          _orderValidationButton,
        ],
      ),
    );
  }
}
