import 'package:flutter/material.dart';

enum IngredientType {
  meal,
  fruit,
  vegetable,
  feculent,
  salsa,
  dairyProducts,
  other
}

class MenuClass {
  String name;
  IconData icon;
  int max;
  int realised;
  ReicipeContent? reicipe;
  IngredientType type;
  MenuClass(
      {this.type = IngredientType.meal,
      this.reicipe,
      required this.name,
      required this.icon,
      required this.max,
      required this.realised});
}

class IngredientContent {
  String name;
  String ingredientImage;
  int number;
  int cal;
  String typeNumber;
  DateTime expirationDate;
  IngredientType type;
  IngredientContent({
    this.type = IngredientType.meal,
    this.name = '',
    this.ingredientImage = 'lib/img/Oignon-de-garde.png',
    this.number = 0,
    this.cal = 0,
    this.typeNumber = 'pieces',
    required this.expirationDate,
  });
}

class ReicipeContent {
  String title;
  String cost;
  String calories;
  String time;
  String reicipe;
  String reicipeImage;
  List<IngredientContent> ingredients;
  ReicipeContent({
    this.reicipe='',
    required this.ingredients,
    this.time = '20 : 00 min',
    this.reicipeImage = '',
    this.calories = '0',
    this.cost = '0',
    this.title = 'New reicipe',
  });
}

class ProfileContent {
  final Icon contenticons;
  final String contenttitle;
  const ProfileContent({
    required this.contenticons,
    required this.contenttitle,
  });
}

class ShopListContent {
  Image image;
  String list;
  List<IngredientContent> product;
  ShopListContent({
    required this.image,
    required this.product,
    this.list = 'Shopping list',
  });
}
