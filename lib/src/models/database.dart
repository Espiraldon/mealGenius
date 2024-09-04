import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealgenius/src/models/content.dart';
import 'package:mealgenius/src/models/ingredientcontent.dart';

Future<IngredientContent?> fetchIngredientByName(String name) async {
  final response =
      await http.get(Uri.parse('http://192.168.1.90:3000/ingredient/$name'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    return IngredientContent(
      name: data['name'] ?? '', // Valeur par défaut si 'name' est null
      ingredientImage: data['ingredient_image'] ??
          'lib/img/default.png', // Valeur par défaut si null
      number: data['number'] ?? 0, // Valeur par défaut si null
      cal: (data['cal'] as num).toDouble(), // Conversion sécurisée en double
      cost: (data['cost'] as num).toDouble(), // Conversion sécurisée en double
      expirationDate: calculateExpirationDate(
        currentDate: DateTime.now(),
        storageMethod: _stringToStorageMethod(data['storage_method']),
        expirationDaysFridge: data['expiration_days_fridge'] ?? 0,
        expirationDaysFreezer: data['expiration_days_freezer'] ?? 0,
        expirationDaysRoomTemp: data['expiration_days_room_temp'] ?? 0,
      ),
      expirationDaysFridge:
          data['expiration_days_fridge'] ?? 0, // Valeur par défaut si null
      expirationDaysFreezer:
          data['expiration_days_freezer'] ?? 0, // Valeur par défaut si null
      expirationDaysRoomTemp:
          data['expiration_days_room_temp'] ?? 0, // Valeur par défaut si null
      nutritionInfo: data['nutrition_info'] ?? '', // Valeur par défaut si null
      origin: data['origin'] ?? '', // Valeur par défaut si null
      seasonality: data['seasonality'] ?? '', // Valeur par défaut si null
      type: _stringToIngredientType(data['type']),
      typeNumber: _stringToNumberType(data['type_number']),
      storageMethod: _stringToStorageMethod(data['storage_method']),
    );
  } else {
    throw Exception('Échec de la récupération de l\'ingrédient');
  }
}

Future<List<IngredientContent>> searchIngredientSuggestions(
    String query) async {
  try {
    // Construire l'URL avec la requête partielle
    final response = await http
        .get(Uri.parse('http://192.168.1.90:3000/ingredient/search/$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Convertir la réponse en liste d'IngredientContent
      return data.map((item) {
        return IngredientContent(
          name: item['name'] ?? '',
          ingredientImage: item['ingredient_image'] ?? 'lib/img/default.png',
          number: item['number'] ?? 0,
          cal: (item['cal'] as num).toDouble(),
          cost: (item['cost'] as num).toDouble(),
          expirationDate: calculateExpirationDate(
            currentDate: DateTime.now(),
            storageMethod: _stringToStorageMethod(item['storage_method']),
            expirationDaysFridge: item['expiration_days_fridge'] ?? 0,
            expirationDaysFreezer: item['expiration_days_freezer'] ?? 0,
            expirationDaysRoomTemp: item['expiration_days_room_temp'] ?? 0,
          ),
          expirationDaysFridge: item['expiration_days_fridge'] ?? 0,
          expirationDaysFreezer: item['expiration_days_freezer'] ?? 0,
          expirationDaysRoomTemp: item['expiration_days_room_temp'] ?? 0,
          nutritionInfo: item['nutrition_info'] ?? '',
          origin: item['origin'] ?? '',
          seasonality: item['seasonality'] ?? '',
          type: _stringToIngredientType(item['type']),
          typeNumber: _stringToNumberType(item['type_number']),
          storageMethod: _stringToStorageMethod(item['storage_method']),
        );
      }).toList();
    } else {
      // Log de l'erreur avec le code de réponse HTTP
      print('Erreur ${response.statusCode}: ${response.reasonPhrase}');
      throw Exception(
          'Erreur lors de la récupération des suggestions. Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception lors de la récupération des suggestions: $e');
    throw Exception('Erreur lors de la récupération des suggestions');
  }
}

// Fonctions pour convertir les strings en ENUMS
IngredientType _stringToIngredientType(String typeString) {
  switch (typeString) {
    case 'fruit':
      return IngredientType.fruit;
    case 'vegetable':
      return IngredientType.vegetable;
    case 'feculent':
      return IngredientType.feculent;
    case 'salsa':
      return IngredientType.salsa;
    case 'dairyProducts':
      return IngredientType.dairyProducts;
    case 'meat':
      return IngredientType.meat;
    case 'fish':
      return IngredientType.fish;
    case 'carbohydrate':
      return IngredientType.carbohydrate;
    case 'legume':
      return IngredientType.legume;
    case 'pasta':
      return IngredientType.pasta;
    case 'boisson':
      return IngredientType.boisson;
    default:
      return IngredientType.other;
  }
}

NumberType _stringToNumberType(String numberTypeString) {
  switch (numberTypeString) {
    case 'Grammes':
      return NumberType.Grammes;
    case 'Litre':
      return NumberType.Litre;
    case 'Pieces':
    default:
      return NumberType.Pieces;
  }
}

StorageMethod _stringToStorageMethod(String storageMethodString) {
  switch (storageMethodString) {
    case 'Frigidaire':
      return StorageMethod.Frigidaire;
    case 'Congélateur':
      return StorageMethod.Congelateur;
    case 'Température ambiante':
    default:
      return StorageMethod.TemperatureAmbiante;
  }
}

DateTime calculateExpirationDate({
  required DateTime currentDate,
  required StorageMethod storageMethod,
  required int expirationDaysFridge,
  required int expirationDaysFreezer,
  required int expirationDaysRoomTemp,
}) {
  // Détermine le nombre de jours en fonction de la méthode de stockage
  int expirationDays;
  switch (storageMethod) {
    case StorageMethod.Frigidaire:
      expirationDays = expirationDaysFridge;
      break;
    case StorageMethod.Congelateur:
      expirationDays = expirationDaysFreezer;
      break;
    case StorageMethod.TemperatureAmbiante:
    default:
      expirationDays = expirationDaysRoomTemp;
  }

  // Calculer la date d'expiration en ajoutant les jours à la date actuelle
  return currentDate.add(Duration(days: expirationDays));
}
