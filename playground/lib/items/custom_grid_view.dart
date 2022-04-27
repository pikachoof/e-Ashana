import 'package:flutter/material.dart';
import 'classes/food_item.dart';
import 'package:playground/screens/food_item_page.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key? key,
    required this.foodItemList,
  }) : super(key: key);

  final List<FoodItem> foodItemList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      children: List.generate(foodItemList.length, (index) {
        final foodItemName = FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            foodItemList[index].name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        );
        final foodItemPrice = FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            '${foodItemList[index].price}₸',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
        final foodItemImage = Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: foodItemList[index].name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage(foodItemList[index].imagePath),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FoodItemPage(foodItem: foodItemList[index]),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var tween = Tween<Offset>(
                    begin: const Offset(1.0, 0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.ease));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.withOpacity(.2),
              ),
              child: Column(
                children: [
                  foodItemImage,
                  foodItemName,
                  foodItemPrice,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
