import 'package:flutter/material.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/authentification.dart';
import 'package:mealgenius/src/models/content.dart';
import 'package:mealgenius/src/screens/guestscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    StreamProvider.value(value: AuthService().user, initialData: null)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MealGenius',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('Ingredients').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: backgroundColor,
                body: Center(
                  child: Image.asset("lib/img/logoprincipaleblanc.png"),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }
            // Fonction pour supprimer les doublons basés sur le nom de l'ingrédient
            myIngredients = myIngredients
                .toSet()
                .toList(); // Conversion en Set pour supprimer les doublons et reconversion en liste.

            if (snapshot.hasData) {
              for (var doc in snapshot.data!.docs) {
                // Récupérer les données depuis le document
                Map<String, dynamic> firestoreData =
                    doc.data() as Map<String, dynamic>;
                Timestamp timestamp = firestoreData["expirationDate"];
                // Conversion des données Firestore en instance de la classe Utilisateur
                IngredientContent ingredient = IngredientContent(
                  name: firestoreData["name"],
                  cost: firestoreData["cost"],
                  cal: firestoreData["cal"],
                  expirationDate: timestamp.toDate(),
                  number: firestoreData["number"],
                  ingredientImage: firestoreData["ingredientImage"],
                );
                // Ajouter l'utilisateur à la liste
                bool ingredientExists = myIngredients.any(
                    (existingIngredient) =>
                        existingIngredient.name == ingredient.name);

                if (!ingredientExists) {
                  myIngredients.add(ingredient);
                }

                //ReicipeContent reicipe =
                //  ReicipeContent(ingredients: firestoreData["name"]);
              }
              return const GuestScreeen();
            }
            return const Text('Aucune donnée disponible');
          },
        ));
  }
}
