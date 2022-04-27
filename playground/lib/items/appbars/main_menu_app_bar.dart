import 'package:flutter/material.dart';
import 'package:playground/screens/search.dart';

class MainMenuAppBar extends StatelessWidget {
  const MainMenuAppBar({Key? key, required this.screenSize}) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    List<Tab> _tabList = [
      Tab(
        height: 70,
        child: Row(
          children: const [
            Image(
              fit: BoxFit.contain,
              height: 50,
              image: AssetImage('images/mainCourse.png'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Горячее',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      Tab(
        height: 70,
        child: Row(
          children: const [
            Image(
              height: 50,
              image: AssetImage('images/drinks.png'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Напитки',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      Tab(
        height: 70,
        child: Row(
          children: const [
            Image(
              height: 50,
              image: AssetImage('images/bakery.png'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Выпечка',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    const _todayMenuText = Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Text(
        'Меню на Сегодня',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    const _categoriesText = Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
      child: Text(
        'Категории',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    var menuIconButton = IconButton(
      icon: const Icon(
        Icons.menu_rounded,
        color: Colors.black,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
    return SliverAppBar(
      pinned: false,
      leading: menuIconButton,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'e-Ashana',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, animation, secondaryAnimation) =>
                    const SearchPage(),
                transitionsBuilder: (_, animation, secondaryAnimation, child) {
                  var tween = Tween<Offset>(
                    begin: const Offset(1.0, 0),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(curve: Curves.ease),
                  );

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _categoriesText,
            TabBar(
              padding: const EdgeInsets.all(4),
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Colors.deepOrange,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(35),
              ),
              tabs: _tabList,
            ),
            _todayMenuText,
          ],
        ),
      ),
    );
  }
}
