import 'package:flutter/material.dart';
import '../classes/food_item.dart';
import 'package:provider/provider.dart';
import 'package:playground/controllers/add_to_cart_text_controller.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    Key? key,
    required this.foodItem,
    required this.screenSize,
  }) : super(key: key);

  final FoodItem foodItem;
  final Size screenSize;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = TweenSequence<Color?>(
      <TweenSequenceItem<Color?>>[
        TweenSequenceItem<Color?>(
          weight: 40,
          tween: ColorTween(begin: Colors.red, end: Colors.green),
        ),
        TweenSequenceItem<Color>(
          weight: 60,
          tween: ConstantTween<Color>(Colors.green),
        ),
      ],
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartContainer(
        controller: controller, widget: widget, animation: animation);
  }
}

class AddToCartContainer extends AnimatedWidget {
  const AddToCartContainer(
      {Key? key,
      required this.controller,
      required this.widget,
      required Animation<Color?> animation})
      : super(key: key, listenable: animation);

  final AnimationController controller;
  final AddToCartButton widget;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<Color?>;
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () async {
        context.read<ShoppingCart>().add(widget.foodItem);
        context.read<AddToCartText>().setText('Добавлено в корзину!');
        await controller.forward();
        await controller.reverse();
        context.read<AddToCartText>().setText('В Корзину');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: animation.value,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    spreadRadius: 5,
                    blurRadius: 5)
              ]),
          child: Align(
              alignment: Alignment.center,
              child: Consumer<AddToCartText>(
                builder: (context, foo, child) => Text(
                  foo.getText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              )),
        ),
      ),
    );
  }
}
