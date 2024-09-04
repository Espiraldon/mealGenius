import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealgenius/src/data/data.dart';
import 'dart:convert';

import 'package:mealgenius/src/models/database.dart';

class MenuClass {
  String name;
  IconData icon;
  int max;
  int realised;
  recipeContent? recipe;
  IngredientType type;
  MenuClass(
      {this.type = IngredientType.meat,
      this.recipe,
      required this.name,
      required this.icon,
      required this.max,
      required this.realised});
}

class IngredientContent {
  String name;
  String ingredientImage;
  int number;
  double cal;
  double cost;
  NumberType typeNumber;
  DateTime expirationDate;
  int expirationDaysFridge;
  int expirationDaysFreezer;
  int expirationDaysRoomTemp;
  String nutritionInfo;
  String origin;
  String seasonality;
  IngredientType type;
  StorageMethod storageMethod;

  IngredientContent({
    this.type = IngredientType.meat,
    this.name = '',
    this.ingredientImage = 'lib/img/Oignon-de-garde.png',
    this.number = 0,
    this.cal = 0.0,
    this.cost = 0.0,
    this.typeNumber = NumberType.Pieces,
    required this.expirationDate,
    this.expirationDaysFridge = 0,
    this.expirationDaysFreezer = 0,
    this.expirationDaysRoomTemp = 0,
    this.nutritionInfo = '',
    this.origin = '',
    this.seasonality = '',
    this.storageMethod = StorageMethod.Frigidaire,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredientImage': ingredientImage,
      'number': number,
      'cal': cal,
      'cost': cost,
      'typeNumber': typeNumber.toString().split('.').last,
      'expirationDate': expirationDate.toIso8601String(),
      'expirationDaysFridge': expirationDaysFridge,
      'expirationDaysFreezer': expirationDaysFreezer,
      'expirationDaysRoomTemp': expirationDaysRoomTemp,
      'nutritionInfo': nutritionInfo,
      'origin': origin,
      'seasonality': seasonality,
      'type': type.toString().split('.').last,
      'storageMethod': storageMethod.toString().split('.').last,
    };
  }

  IngredientContent copy() {
    return IngredientContent(
      type: type,
      name: name,
      expirationDate: expirationDate,
      cal: cal,
      ingredientImage: ingredientImage,
      number: number,
      typeNumber: typeNumber,
      cost: cost,
      expirationDaysFridge: expirationDaysFridge,
      expirationDaysFreezer: expirationDaysFreezer,
      expirationDaysRoomTemp: expirationDaysRoomTemp,
      nutritionInfo: nutritionInfo,
      origin: origin,
      seasonality: seasonality,
      storageMethod: storageMethod,
    );
  }

  factory IngredientContent.fromFirestore(Map<String, dynamic> firestoreData) {
    // Conversion du Timestamp en DateTime
    Timestamp timestamp = firestoreData["expirationDate"];

    // Conversion de String en NumberType
    NumberType numberType;
    switch (firestoreData["typeNumber"]) {
      case "Grammes":
        numberType = NumberType.Grammes;
        break;
      case "Litre":
        numberType = NumberType.Litre;
        break;
      case "Pieces":
      default:
        numberType = NumberType.Pieces;
    }

    // Conversion de String en IngredientType
    IngredientType ingredientType;
    switch (firestoreData["type"]) {
      case "vegetable":
        ingredientType = IngredientType.vegetable;
        break;
      case "fruit":
        ingredientType = IngredientType.fruit;
        break;
      case "meat":
        ingredientType = IngredientType.meat;
        break;
      case "fish":
        ingredientType = IngredientType.fish;
        break;
      case "carbohydrate":
        ingredientType = IngredientType.carbohydrate;
        break;
      case "legume":
        ingredientType = IngredientType.legume;
        break;
      case "pasta":
        ingredientType = IngredientType.pasta;
        break;
      case "boisson":
        ingredientType = IngredientType.boisson;
        break;
      default:
        ingredientType = IngredientType.other;
    }

    // Conversion de String en StorageMethod
    StorageMethod storageMethod;
    switch (firestoreData["storageMethod"]) {
      case "Frigidaire":
        storageMethod = StorageMethod.Frigidaire;
        break;
      case "Congelateur":
        storageMethod = StorageMethod.Congelateur;
        break;
      case "Température ambiante":
      default:
        storageMethod = StorageMethod.TemperatureAmbiante;
    }

    return IngredientContent(
      name: firestoreData["name"] ?? '',
      ingredientImage:
          firestoreData["ingredientImage"] ?? 'lib/img/Oignon-de-garde.png',
      number: firestoreData["number"] ?? 0,
      cal: firestoreData["cal"]?.toDouble() ?? 0.0,
      cost: firestoreData["cost"]?.toDouble() ?? 0.0,
      expirationDate: timestamp.toDate(),
      typeNumber: numberType,
      expirationDaysFridge: firestoreData["expirationDaysFridge"] ?? 0,
      expirationDaysFreezer: firestoreData["expirationDaysFreezer"] ?? 0,
      expirationDaysRoomTemp: firestoreData["expirationDaysRoomTemp"] ?? 0,
      nutritionInfo: firestoreData["nutritionInfo"] ?? '',
      origin: firestoreData["origin"] ?? '',
      seasonality: firestoreData["seasonality"] ?? '',
      type: ingredientType,
      storageMethod: storageMethod,
    );
  }
}

enum NumberType { Grammes, Pieces, Litre }

enum IngredientType {
  fruit,
  vegetable,
  feculent,
  salsa,
  dairyProducts,
  other,
  meat,
  fish,
  carbohydrate,
  legume,
  pasta,
  boisson,
}

enum StorageMethod {
  Frigidaire,
  Congelateur,
  TemperatureAmbiante,
}

class recipeContent {
  String title;
  String cost;
  String calories;
  String glucides;
  String proteines;
  String lipides;
  String time;
  String recipe;
  String recipeImage;
  List<IngredientContent> ingredients;

  recipeContent({
    this.recipe = '',
    required this.ingredients,
    this.time = '20 : 00 min',
    this.recipeImage = '',
    this.calories = '0',
    this.glucides = '0',
    this.lipides = '0',
    this.proteines = '0',
    this.cost = '0',
    this.title = 'New recipe',
  });
  recipeContent copy() {
    return recipeContent(
        ingredients: ingredients,
        recipe: recipe,
        recipeImage: recipeImage,
        time: time,
        calories: calories,
        cost: cost,
        title: title);
  }

  recipeContent recipeFromFirestore(Map<String, dynamic> firestoreData,
      List<IngredientContent> ingredientKnown) {
    // Liste des noms d'ingrédients récupérés depuis Firestore
    List<String> ingredientNames =
        List<String>.from(firestoreData["ingredients"]);

    // Liste des nombres associés à chaque ingrédient
    List<int> ingredientNumbers =
        List<int>.from(firestoreData["ingredientNumbers"]);

    // Liste pour stocker les ingrédients trouvés et ajustés
    List<IngredientContent> ingredientsInRecipe = [];

    // Parcourir les ingrédients récupérés depuis Firestore
    for (int i = 0; i < ingredientNames.length; i++) {
      String ingredientName = ingredientNames[i];
      int ingredientNumber = ingredientNumbers[i];

      // Chercher l'ingrédient correspondant dans la liste ingredientKnown
      IngredientContent? knownIngredient = ingredientKnown.firstWhere(
        (ingredient) => ingredient.name == ingredientName,
        orElse: () => IngredientContent(
            expirationDate:
                DateTime.now()), // Ingrédient par défaut si non trouvé
      );

      // Créer une copie de l'ingrédient trouvé et ajuster son nombre
      IngredientContent ingredientCopy = knownIngredient.copy();
      ingredientCopy.number = ingredientNumber;

      // Ajouter l'ingrédient ajusté à la liste des ingrédients de la recette
      ingredientsInRecipe.add(ingredientCopy);
    }

    // Création de l'instance recipeContent avec les ingrédients ajustés
    return recipeContent(
      title: firestoreData["title"] ?? 'New recipe',
      cost: firestoreData["cost"] ?? '0',
      calories: firestoreData["calories"] ?? '0',
      glucides: firestoreData["glucides"] ?? '0',
      proteines: firestoreData["proteines"] ?? '0',
      lipides: firestoreData["lipides"] ?? '0',
      time: firestoreData["time"] ?? '20 : 00 min',
      recipe: firestoreData["recipe"] ?? '',
      recipeImage: firestoreData["recipeImage"] ?? '',
      ingredients: ingredientsInRecipe,
    );
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

void addIngredientToFirebase(IngredientContent ingredient) async {
  try {
    await FirebaseFirestore.instance.collection('Ingredients').add({
      'name': ingredient.name,
      'cost': ingredient.cost,
      'cal': ingredient.cal,
      'expirationDate': Timestamp.fromDate(ingredient.expirationDate),
      'number': ingredient.number,
      'ingredientImage': ingredient.ingredientImage,
      'expirationDaysFridge': ingredient.expirationDaysFridge,
      'expirationDaysFreezer': ingredient.expirationDaysFreezer,
      'expirationDaysRoomTemp': ingredient.expirationDaysRoomTemp,
      'nutritionInfo': ingredient.nutritionInfo,
      'origin': ingredient.origin,
      'seasonality': ingredient.seasonality,
      'type': ingredient.type.toString().split('.').last,
      'storageMethod': ingredient.storageMethod.toString().split('.').last,
    });
    print("Ingrédient ajouté avec succès");
  } catch (e) {
    print("Erreur lors de l'ajout de l'ingrédient : $e");
  }
}

Future<void> removeIngredientByName(String ingredientName) async {
  try {
    // Cherche le document avec le nom de l'ingrédient
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Ingredients')
        .where('name', isEqualTo: ingredientName)
        .get();

    // Vérifie s'il existe des documents correspondant au nom de l'ingrédient
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Supprime chaque document correspondant au nom
        await FirebaseFirestore.instance
            .collection('Ingredients')
            .doc(doc.id)
            .delete();
        print("Ingrédient supprimé avec succès");
      }
    } else {
      print("Aucun ingrédient trouvé avec ce nom");
    }
  } catch (e) {
    print("Erreur lors de la suppression de l'ingrédient : $e");
  }
}
