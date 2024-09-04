import 'package:flutter/material.dart';
import 'package:mealgenius/src/models/ingredientcontent.dart';

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
