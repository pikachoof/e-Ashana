import 'package:flutter/material.dart';
import 'package:playground/items/classes/food_item.dart';
import 'package:playground/screens/food_item_page.dart';
import 'package:playground/data/food_item_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<FoodItem> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    var _searchField = SearchField(
      onChanged: searchQuery,
    );
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shadowColor: Colors.red,
              backgroundColor: Colors.white,
              pinned: false,
              floating: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: _searchField,
            ),
            (_searchResults.isEmpty)
                ? const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Ничего не найдено :(',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) =>
                          SearchFoodItem(foodItem: _searchResults[index]),
                      childCount: _searchResults.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void searchQuery(String value) {
    value = value.toLowerCase();
    List<FoodItem> queryResults = [];
    for (List<FoodItem> item in allFoodItems) {
      for (FoodItem foodItem in item) {
        String currentName = foodItem.name.toLowerCase();
        if (currentName.contains(value)) {
          queryResults.add(foodItem);
        }
      }
    }
    setState(() {
      _searchResults = queryResults;
    });
  }
}

class SearchFoodItem extends StatelessWidget {
  const SearchFoodItem({Key? key, required this.foodItem}) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Image(
              fit: BoxFit.fill,
              width: 125,
              height: double.infinity,
              image: AssetImage(foodItem.imagePath),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              foodItem.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              foodItem.shortDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${foodItem.price}₸',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await Future.delayed(
                    const Duration(milliseconds: 200),
                  );
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          FoodItemPage(foodItem: foodItem),
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 8),
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.deepOrange,
                        Colors.yellow,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Перейти',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      onTap: () {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
        } else {
          focusNode.requestFocus();
        }
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 16),
        constraints: const BoxConstraints(maxHeight: 45),
        hintText: 'Введите запрос...',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
