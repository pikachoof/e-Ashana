import 'package:flutter/material.dart';
import 'package:playground/items/classes/splash_page.dart';
import 'package:playground/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<SplashPage> _splashPages = const [
    SplashPage(text: 'Добро пожаловать! Приступим?', image: 'images/OOF.jpg'),
    SplashPage(text: 'Заказывай еду в столовой!', image: 'images/OOF.jpg'),
    SplashPage(text: 'Чего же ты ждёшь? Заказывай!', image: 'images/OOF.jpg'),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var _dynamicDots = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            _splashPages.length, (index) => buildDot(index: index)),
      ),
    );
    var _proceedButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainMenu(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
          child: Container(
            //duration: const Duration(milliseconds: 600),
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
              gradient: const LinearGradient(
                  colors: [Colors.redAccent, Colors.orange]),
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
                'Готово',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: ((value) => setState(
                      () {
                        currentPage = value;
                      },
                    )),
                itemCount: _splashPages.length,
                itemBuilder: (context, index) => SplashContent(
                  text: _splashPages[index].text,
                  image: _splashPages[index].image,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dynamicDots,
                  _proceedButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 150),
      width: (currentPage == index) ? 32 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: (currentPage == index)
            ? Colors.deepOrange
            : Colors.grey.withOpacity(.5),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const Text(
          'e-Ashana',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(flex: 2),
        Image(
          image: AssetImage(image),
        ),
      ],
    );
  }
}
