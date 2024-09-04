import 'package:mealgenius/src/models/content.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<IngredientType> type = [
  IngredientType.dairyProducts,
  IngredientType.feculent,
  IngredientType.fruit,
  IngredientType.meat,
  IngredientType.other,
  IngredientType.salsa,
  IngredientType.vegetable,
  IngredientType.fish,
  IngredientType.pasta,
  IngredientType.carbohydrate,
  IngredientType.boisson
];
List<IngredientContent> myIngredients = [];
List<ShopListContent> recommandationShopList = [];
List<ShopListContent> myShopList = [];

List<IngredientContent> ingredientsKnown = [
      IngredientContent(
          type: IngredientType.fruit,
          name: 'oignon',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 2000,
          cost: 1.0,
          expirationDate: DateTime(2023, 7, 19)),
      IngredientContent(
          type: IngredientType.fruit,
          name: 'Fraise',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 1000,
          cost: 5,
          expirationDate: DateTime(2023, 7, 30)),
    ] +
    [
      IngredientContent(
        type: IngredientType.meat,
        name: 'Beaf',
        ingredientImage: "lib/img/Oignon-de-garde.png",
        number: 1,
        cal: 1000,
        cost: 10,
        expirationDate: DateTime(2023, 7, 30),
      ),
    ] +
    [
      IngredientContent(
          type: IngredientType.feculent,
          name: 'Pasta',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 800,
          cost: 2,
          expirationDate: DateTime(2023, 8, 30)),
    ] +
    [
      IngredientContent(
          type: IngredientType.vegetable,
          name: 'tomato',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 500,
          cost: 1,
          expirationDate: DateTime(2023, 7, 15))
    ];
List<IngredientContent> expiredIngredients = myIngredients
    .where((element) =>
        element.expirationDate.difference(DateTime.now()).inDays <= 0)
    .toList();

int currentday = DateTime.now().weekday;
