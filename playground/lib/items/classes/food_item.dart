class FoodItem {
  final String name;
  final int price;
  int quantity = 1;
  String imagePath;
  String shortDescription = "Какой-нибудь текст";
  String longDescription = "Изумительный вкус, завораживающий запах, ну и конечно же, приятная цена!";
  FoodItem(this.name, this.price, this.imagePath);
}
