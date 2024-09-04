import '../models/content.dart';
import 'data.dart';

List<recipeContent> myrecipe = [];

List<recipeContent>? monday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? tuesday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? wenesday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? thirsday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? friday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? saturday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<recipeContent>? sunday =
    List<recipeContent>.filled(4, recipeContent(ingredients: []));
List<List<recipeContent>?> weekday = [
  monday,
  tuesday,
  wenesday,
  thirsday,
  friday,
  saturday,
  sunday
];
List<recipeContent>? todayrecipe = weekday[(currentday - 1) % 7];
