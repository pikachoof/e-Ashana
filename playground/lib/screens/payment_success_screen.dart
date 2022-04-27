import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:playground/items/buttons/custom_button.dart';
import 'package:playground/main.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const PaymentSuccessMessage();
            } else {
              return SpinKitFadingCircle(
                size: 75,
                itemBuilder: (BuildContext context, int index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class PaymentSuccessMessage extends StatefulWidget {
  const PaymentSuccessMessage({Key? key}) : super(key: key);

  @override
  _PaymentSuccessMessageState createState() => _PaymentSuccessMessageState();
}

class _PaymentSuccessMessageState extends State<PaymentSuccessMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInExpo),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _paymentSuccessText = Container(
      alignment: AlignmentDirectional.center,
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: const Text(
        'Оплата прошла успешно!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.green,
        ),
      ),
    );
    final _homeButton = CustomButton(
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
      widget: const Icon(Icons.home_rounded, size: 42),
      someContext: context,
    );
    return FadeTransition(
      opacity: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _paymentSuccessText,
          _homeButton,
        ],
      ),
    );
  }
}
