import 'package:flutter/material.dart';
import 'package:playground/items/classes/drawer_button.dart';
import 'package:playground/screens/cart.dart';
import 'package:playground/screens/orders.dart';
import 'package:playground/screens/profile.dart';
import 'package:playground/screens/settings.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);

  final List<DrawerButton> _drawerButtons = [
    DrawerButton(
      'Мои заказы',
      const Icon(
        Icons.shopping_bag_outlined,
        color: Colors.black,
      ),
    ),
    DrawerButton(
      'Мой профиль',
      const Icon(
        Icons.person_outlined,
        color: Colors.black,
      ),
    ),
    DrawerButton(
      'Настройки',
      const Icon(
        Icons.settings_outlined,
        color: Colors.black,
      ),
    ),
    DrawerButton(
      'Корзина',
      const Icon(
        Icons.shopping_cart_outlined,
        color: Colors.black,
      ),
    ),
  ];

  final List<Widget> _pages = [
    const OrderPageBody(),
    const ProfilePageBody(),
    const SettingsPageBody(),
    const CartPageBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 1,
            child: CircleAvatar(
              radius: 56,
              foregroundImage: AssetImage('images/OOF.jpg'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _drawerButtons.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      _pages[index],
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var tween = Tween<Offset>(
                                        begin: const Offset(1.0, 0),
                                        end: Offset.zero)
                                    .chain(CurveTween(curve: Curves.ease));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          ),
                          leading: _drawerButtons[index].child,
                          title: Text(
                            _drawerButtons[index].name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                        );
                      },
                    ),
                  ),
                  const Text(
                    'Qadam inc.\u2122',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
