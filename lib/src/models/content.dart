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
  double cost;
  String typeNumber;
  DateTime expirationDate;
  IngredientType type;
  IngredientContent({
    this.type = IngredientType.meal,
    this.name = '',
    this.ingredientImage = 'lib/img/Oignon-de-garde.png',
    this.number = 0,
    this.cal = 0,
    this.cost = 0.0,
    this.typeNumber = 'pieces',
    required this.expirationDate,
  });
  IngredientContent copy() {
    return IngredientContent(
        type: type,
        name: name,
        expirationDate: expirationDate,
        cal: cal,
        ingredientImage: ingredientImage,
        number: number,
        typeNumber: typeNumber);
  }
}

class ReicipeContent {
  String title;
  String cost;
  String calories;
  String glucides;
  String proteines;
  String lipides;
  String time;
  String reicipe;
  String reicipeImage;
  List<IngredientContent> ingredients;
  ReicipeContent({
    this.reicipe = '',
    required this.ingredients,
    this.time = '20 : 00 min',
    this.reicipeImage = '',
    this.calories = '0',
    this.glucides = '0',
    this.lipides = '0',
    this.proteines = '0',
    this.cost = '0',
    this.title = 'New reicipe',
  });
  ReicipeContent copy() {
    return ReicipeContent(
        ingredients: ingredients,
        reicipe: reicipe,
        reicipeImage: reicipeImage,
        time: time,
        calories: calories,
        cost: cost,
        title: title);
  }
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
