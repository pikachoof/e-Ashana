import 'package:flutter/material.dart';
import 'package:playground/controllers/add_to_cart_text_controller.dart';
import 'package:playground/controllers/order_controller.dart';
import 'package:playground/controllers/search_controller.dart';
import 'package:playground/controllers/shopping_cart_controller.dart';
import 'package:playground/items/main_drawer.dart';
import 'package:playground/screens/authorization.dart';
import 'screens/main_menu.dart';
import 'package:provider/provider.dart';
import 'controllers/page_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCart()),
        ChangeNotifierProvider(create: (_) => AddToCartText()),
        ChangeNotifierProvider(create: (_) => PGController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
        ChangeNotifierProvider(create: (_) => SearchController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nunito'),
      debugShowCheckedModeBanner: false,
      //home: const MainMenu(),
      //home: const OnboardingScreen(),
      home: const AuthorizationScreen(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: MainMenuPageBody(),
      ),
      drawer: MainDrawer(),
    );
  }
}
