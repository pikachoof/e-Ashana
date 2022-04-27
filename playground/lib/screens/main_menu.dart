import 'package:flutter/material.dart';
import 'package:playground/items/classes/food_item.dart';
import 'package:playground/items/custom_grid_view.dart';
import 'package:playground/items/appbars/main_menu_app_bar.dart';
import 'package:playground/data/food_item_data.dart';

class MainMenuPageBody extends StatelessWidget {
  const MainMenuPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List<List<FoodItem>> _items = allFoodItems;
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (_, value) {
          return [
            MainMenuAppBar(screenSize: screenSize),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: List.generate(
                  3,
                  (index) => CustomGridView(
                    foodItemList: _items[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
