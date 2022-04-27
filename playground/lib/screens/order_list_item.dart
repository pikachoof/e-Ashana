import 'package:flutter/material.dart';
import 'package:playground/items/classes/order_item.dart';
import 'package:playground/items/order_food_item.dart';

class OrderListItemBody extends StatelessWidget {
  const OrderListItemBody({Key? key, required this.orderItem})
      : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Информация о заказе',
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
    var _totalItemCount = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Кол-во продуктов: ${orderItem.orderItems.length}',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
    var _totalPrice = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Итог: ${orderItem.totalPrice}₸',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
    var _orderFoodItemList = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(8),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(.15),
      ),
      child: ListView.builder(
        itemCount: orderItem.orderItems.length,
        itemBuilder: (context, index) => OrderFoodItem(
          foodItem: orderItem.orderItems[index],
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
              children: [
                const Icon(Icons.gps_fixed_rounded),
                const SizedBox(width: 8),
                Text(
                  orderItem.pickupLocation,
                  style: const TextStyle(
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
        ],
      ),
    );
    return Scaffold(
      appBar: _appBar,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _yourOrderText,
                _totalItemCount,
                _totalPrice,
                _orderFoodItemList,
                _pickupPointContainer,
                _paymentMethodContainer,
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
