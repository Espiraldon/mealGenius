import 'package:flutter/material.dart';
import 'package:happly/src/models/content.dart';

final List<IngredientContent> fruits_data = [
  IngredientContent(
      type: IngredientType.fruit,
      name: 'oignon',
      ingredientImage: "lib/img/Oignon-de-garde.png",
      number: 1,
      cal: 2000,
      cost: 1,
      expirationDate: DateTime(2023, 7, 19)),
  IngredientContent(
      type: IngredientType.fruit,
      name: 'Fraise',
      ingredientImage: "lib/img/Oignon-de-garde.png",
      number: 1,
      cal: 1000,
      cost: 5,
      expirationDate: DateTime(2023, 7, 30)),
];
final List<IngredientContent> vegetables_data = [
  IngredientContent(
      type: IngredientType.vegetable,
      name: 'tomato',
      ingredientImage: "lib/img/Oignon-de-garde.png",
      number: 1,
      cal: 500,
      cost: 1,
      expirationDate: DateTime(2023, 7, 15)),
];
final List<IngredientContent> Meal_data = [
  IngredientContent(
      type: IngredientType.meal,
      name: 'Beaf',
      ingredientImage: "lib/img/Oignon-de-garde.png",
      number: 1,
      cal: 1000,
      cost: 10,
      expirationDate: DateTime(2023, 7, 30),
      typeNumber: 'piece'),
];
List<IngredientContent> feculent_data = [
  IngredientContent(
      type: IngredientType.feculent,
      name: 'Pasta',
      ingredientImage: "lib/img/Oignon-de-garde.png",
      number: 1,
      cal: 800,
      cost: 2,
      expirationDate: DateTime(2023, 8, 30)),
];
List<ProfileContent> MyAccount = [
  const ProfileContent(
      contenticons: Icon(Icons.info_outline_rounded),
      contenttitle: "Account informations"),
  const ProfileContent(
      contenticons: Icon(Icons.notifications),
      contenttitle: "notifications methods"),
];
List<ProfileContent> Application = [
  const ProfileContent(
      contenticons: Icon(Icons.upload_rounded),
      contenttitle: "Import ingrédients"),
  const ProfileContent(
      contenticons: Icon(Icons.upload_rounded), contenttitle: "import Reicipe"),
];
List<ProfileContent> Support = [
  const ProfileContent(contenticons: Icon(Icons.help), contenttitle: "Help us"),
  const ProfileContent(
      contenticons: Icon(Icons.phone), contenttitle: "Contact us"),
  const ProfileContent(
      contenticons: Icon(Icons.account_box), contenttitle: "Private data"),
];
ReicipeContent pasta = ReicipeContent(
    time: '20 - 25 min',
    title: 'Pates à la carbonnara',
    cost: '10',
    calories: '500',
    lipides: '27',
    glucides: '60',
    proteines: '30',
    reicipeImage: "lib/img/Pates-a-la-carbonara-2-500x500.webp",
    ingredients: feculent_data);
ReicipeContent pasta2 = ReicipeContent(
    time: '10 - 15 min',
    title: 'Reicipe',
    cost: '50',
    calories: '250',
    lipides: '60',
    glucides: '27',
    proteines: '59',
    reicipeImage: 'lib/img/Pates-a-la-carbonara-2-500x500.webp',
    ingredients: [Meal_data[0].copy()]);

List<ShopListContent> recommandationShopList = [];
List<ShopListContent> myShopList = [];
List<IngredientContent> myIngredients =
    fruits_data + Meal_data + feculent_data + vegetables_data;
List<IngredientContent> ingredientsKnown = [
      IngredientContent(
          type: IngredientType.fruit,
          name: 'oignon',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 2000,
          cost: 1,
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
          type: IngredientType.meal,
          name: 'Beaf',
          ingredientImage: "lib/img/Oignon-de-garde.png",
          number: 1,
          cal: 1000,
          cost: 10,
          expirationDate: DateTime(2023, 7, 30),
          typeNumber: 'piece'),
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
List<ReicipeContent> myReicipe = [pasta, pasta2];

int currentday = DateTime.now().weekday;

List<ReicipeContent>? monday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? tuesday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? wenesday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? thirsday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? friday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? saturday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<ReicipeContent>? sunday =
    List<ReicipeContent>.filled(4, ReicipeContent(ingredients: []));
List<List<ReicipeContent>?> weekday = [
  monday,
  tuesday,
  wenesday,
  thirsday,
  friday,
  saturday,
  sunday
];
List<ReicipeContent>? todayReicipe = weekday[currentday];
