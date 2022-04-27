import 'package:playground/items/classes/food_item.dart';

final List<FoodItem> mainCourse = [
  FoodItem('Борщ', 150, 'images/Borsh.jpg'),
  FoodItem('Гречка с мясом', 135, 'images/GrechkaSMyasom.jpg'),
  FoodItem('Котлета с пюре', 120, 'images/KotletaSPure.jpg'),
  FoodItem('Плов с курицей', 200, 'images/PlovSKuricei.jpg'),
  FoodItem('Суп харчо', 130, 'images/SupHarcho.jpg'),
  FoodItem('Котлета с рисом', 125, 'images/KotletaSRisom.jpg'),
];

final List<FoodItem> drinks = [
  FoodItem('Чай чёрный', 100, "images/ChaiChernyi.jpg"),
  FoodItem('Чай с молоком', 70, "images/ChaiSMolokom.jpg"),
  FoodItem('Кофе', 120, "images/Kofe.jpg"),
  FoodItem('Компот', 90, "images/Kompot.jpg"),
  FoodItem('Молоко', 100, "images/Moloko.jpg"),
  FoodItem('Морс', 100, "images/Mors.jpg"),
];

final List<FoodItem> snacks = [
  FoodItem('Сникерс', 150, "images/Snickers.jpg"),
  FoodItem('Джумка', 130, "images/Djumka.jpg"),
  FoodItem('Сосиска в тесте', 130, "images/SosiskiVTeste.jpg"),
  FoodItem('Корж', 100, "images/Korzhik.jpg"),
  FoodItem('Кекс', 120, "images/Keks.jpg"),
  FoodItem('Булочка', 110, "images/Bulochka.jpg"),
  FoodItem('Самса', 110, "images/Samsa.jpg"),
];

final List<List<FoodItem>> allFoodItems = [mainCourse, drinks, snacks];
