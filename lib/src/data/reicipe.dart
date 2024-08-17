import '../models/content.dart';
import 'data.dart';

List<ReicipeContent> myReicipe = [];

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
List<ReicipeContent>? todayReicipe = weekday[(currentday - 1) % 7];
