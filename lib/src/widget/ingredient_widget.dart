import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealgenius/src/models/database.dart';
import 'package:permission_handler/permission_handler.dart';

class IngredientDetailsPage extends StatefulWidget {
  final IngredientContent ingredient;

  IngredientDetailsPage({required this.ingredient});

  @override
  _IngredientDetailsPageState createState() => _IngredientDetailsPageState();
}

class _IngredientDetailsPageState extends State<IngredientDetailsPage> {
  late int selectedNumber;
  late String selectedStorageMethod;
  late double totalCost;
  String ingredientImageUrl = '';
  final ImagePicker _picker = ImagePicker();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialisation des valeurs par défaut
    selectedNumber = widget.ingredient.number;
    selectedStorageMethod = getRecommendedStorageMethod();
    totalCost = widget.ingredient.cost * selectedNumber;
    ingredientImageUrl = widget.ingredient.ingredientImage;
  }

  void _increaseNumber() {
    setState(() {
      selectedNumber++;
      totalCost = widget.ingredient.cost * selectedNumber;
    });
  }

  void _decreaseNumber() {
    if (selectedNumber > 1) {
      setState(() {
        selectedNumber--;
        totalCost = widget.ingredient.cost * selectedNumber;
      });
    }
  }

  void _startIncreaseTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _increaseNumber();
    });
  }

  void _startDecreaseTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _decreaseNumber();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String getRecommendedStorageMethod() {
    if (widget.ingredient.expirationDaysFridge != 0) return 'Frigidaire';
    if (widget.ingredient.expirationDaysFreezer != 0) return 'Congélateur';
    if (widget.ingredient.expirationDaysRoomTemp != 0)
      return 'Température ambiante';
    return 'Frigidaire'; // Valeur par défaut si aucune recommandation n'existe
  }

  List<String> getAvailableStorageMethods() {
    List<String> methods = [];
    if (widget.ingredient.expirationDaysFridge != 0) methods.add('Frigidaire');
    if (widget.ingredient.expirationDaysFreezer != 0)
      methods.add('Congélateur');
    if (widget.ingredient.expirationDaysRoomTemp != 0)
      methods.add('Température ambiante');
    return methods;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        ingredientImageUrl = pickedFile.path;
      });
    }
  }

  Future<void> _requestPermissions() async {
    await Permission.photos.request();
    await Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    String mesure;
    if (widget.ingredient.typeNumber == NumberType.Grammes) {
      mesure = 'Masse';
    } else if (widget.ingredient.typeNumber == NumberType.Litre) {
      mesure = 'Volume';
    } else {
      mesure = 'Nombre';
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.ingredient.name),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de l'ingrédient
            GestureDetector(
              onTap: () => _showImageSourceDialog(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ingredientImageUrl.startsWith('http')
                    ? Image.network(
                        ingredientImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      )
                    : Image.file(
                        File(ingredientImageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Information de l'ingrédient dans une carte
            Card(
              color: backgroundColor2,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${widget.ingredient.name}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$mesure: $selectedNumber ${widget.ingredient.typeNumber.toString().split('.').last}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Calories: ${widget.ingredient.cal} kcal",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Total Cost: \$${totalCost.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Nutrition Info: ${widget.ingredient.nutritionInfo}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Origin: ${widget.ingredient.origin}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    widget.ingredient.seasonality != ''
                        ? Text(
                            "Seasonality: ${widget.ingredient.seasonality}",
                            style: const TextStyle(fontSize: 18),
                          )
                        : Text(
                            "Seasonality: All year",
                            style: const TextStyle(fontSize: 18),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sélection du nombre
            Text(
              "Select Number:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: _decreaseNumber,
                  onLongPress: _startDecreaseTimer,
                  onLongPressUp: _stopTimer,
                  child: Icon(Icons.remove),
                ),
                Text(
                  selectedNumber.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: _increaseNumber,
                  onLongPress: _startIncreaseTimer,
                  onLongPressUp: _stopTimer,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sélection de la méthode de conservation
            Text(
              "Select Storage Method:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedStorageMethod,
              items: getAvailableStorageMethods()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStorageMethod = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Conseils de conservation
            if (getRecommendedStorageMethod() == selectedStorageMethod)
              Text(
                "Recommended method: $selectedStorageMethod",
                style: TextStyle(color: positive, fontSize: 16),
              ),
            if (getRecommendedStorageMethod() != selectedStorageMethod)
              Text(
                "It is recommended to store in: ${getRecommendedStorageMethod()}",
                style: TextStyle(color: positive, fontSize: 16),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action de sauvegarde ici
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Saved $selectedNumber ${widget.ingredient.name} in $selectedStorageMethod"),
            ),
          );
          Navigator.pop(context);
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
        backgroundColor: secondColor,
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick from Gallery'),
                onTap: () async {
                  await _requestPermissions();
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a Photo'),
                onTap: () async {
                  await _requestPermissions();
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Enter Image URL'),
                onTap: () {
                  _showUrlInputDialog();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUrlInputDialog() {
    TextEditingController urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Image URL'),
          content: TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: "URL"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  ingredientImageUrl = urlController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class IngredientsWidget extends StatefulWidget {
  List<IngredientContent>? ingredientItems;
  IngredientsWidget({
    this.ingredientItems,
    super.key,
  });

  @override
  State<IngredientsWidget> createState() => _IngredientsWidgetState();
}

class _IngredientsWidgetState extends State<IngredientsWidget> {
  NumberType Selectoption = NumberType.Grammes;
  List<NumberType> typeNumber = [
    NumberType.Grammes,
    NumberType.Litre,
    NumberType.Pieces
  ];
  IngredientType Selectoption2 = IngredientType.dairyProducts;

  List<IngredientContent> suggestions = [];
  IngredientContent? selectedIngredient;

  void addItem() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        IngredientContent newIngredient =
            IngredientContent(expirationDate: DateTime.now());
        newIngredient.type = Selectoption2;
        newIngredient.typeNumber = Selectoption;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 16,
                right: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Ingredients',
                      style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 25,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) async {
                        newIngredient.name = value;

                        // Chercher des suggestions dans la base de données en temps réel
                        if (value.isNotEmpty) {
                          List<IngredientContent> newSuggestions =
                              await searchIngredientSuggestions(value);
                          if (mounted) {
                            setModalState(() {
                              suggestions = newSuggestions;
                            });
                          }
                        }
                      },
                      decoration: InputDecoration(
                        label: Text(
                          'name',
                          style: GoogleFonts.lato(
                              color: tipo,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Affichage des suggestions dans une liste déroulante
                    if (suggestions.isNotEmpty)
                      DropdownButton<IngredientContent>(
                        isExpanded: true,
                        hint: const Text("Select Ingredient"),
                        value: selectedIngredient != null &&
                                suggestions.contains(selectedIngredient)
                            ? selectedIngredient
                            : null, // Assure que la sélection est cohérente avec les suggestions
                        items: suggestions.map((ingredient) {
                          return DropdownMenuItem<IngredientContent>(
                            value: ingredient,
                            child: Text(ingredient.name),
                          );
                        }).toList(),
                        onChanged: (IngredientContent? newValue) {
                          setState(() {
                            selectedIngredient = newValue;
                            if (newValue != null) {
                              newIngredient =
                                  newValue; // Mettre à jour l'ingrédient sélectionné
                            }
                          });
                        },
                      ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(primaryColor),
                      ),
                      onPressed: () {
                        if (selectedIngredient != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => IngredientDetailsPage(
                                ingredient: selectedIngredient!,
                              ),
                            ),
                          );
                        } else {
                          print("Veuillez sélectionner un ingrédient.");
                        }
                      },
                      child: Text(
                        'Show Ingredient Details',
                        style: GoogleFonts.lato(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () => Navigator.of(context).pop(),
                          backgroundColor: primaryColor,
                          child: Icon(Icons.close, size: 20, color: tipo),
                        ),
                        TextButton(
                          onPressed: () => setModalState(() {
                            if (newIngredient.name.isNotEmpty) {
                              if (newIngredient.ingredientImage ==
                                  'lib/img/Oignon-de-garde.png') {
                                newIngredient.ingredientImage =
                                    'url_par_defaut.png'; // Image par défaut si aucune n'est choisie
                              }

                              myIngredients.add(newIngredient.copy());
                              ingredientsKnown.add(newIngredient.copy());
                              widget.ingredientItems!.add(newIngredient.copy());

                              addIngredientToFirebase(newIngredient);
                              Navigator.of(context).pop();
                            } else {
                              print("Le nom est obligatoire");
                            }
                          }),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.lato(
                                color: tipo,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 450,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.ingredientItems!.length,
              itemBuilder: (BuildContext context, int index) {
                IngredientContent ingredient = widget.ingredientItems![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Dismissible(
                    key: Key(ingredient.name),
                    direction: DismissDirection.vertical,
                    background: Container(
                      color: primaryColor,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Icon(
                        Icons.delete,
                        color: white,
                      ),
                    ),
                    onDismissed: (direction) {
                      removeIngredientByName(ingredient.name);
                    },
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the Ingredient Details Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IngredientDetailsPage(
                              ingredient: ingredient,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 430,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryColor,
                        ),
                        child: Stack(
                          children: [
                            // Information et Image de l'ingrédient
                            Positioned(
                              left: 40,
                              top: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ingredient.name,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                    ),
                                  ),
                                  Text(
                                    '${ingredient.cal} kcal',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        ingredient.ingredientImage),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // Boutons pour augmenter ou diminuer le nombre
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  ingredient.number++;
                                }),
                                child: Container(
                                  height: 90,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: negative,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(Icons.add, color: white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  if (ingredient.number > 1) {
                                    ingredient.number--;
                                  }
                                }),
                                child: Container(
                                  height: 90,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: positive,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(Icons.remove, color: white),
                                ),
                              ),
                            ),
                            // Affichage du nombre d'unités
                            Positioned(
                              left: 20,
                              bottom: 20,
                              child: Text(
                                '${ingredient.number} ${ingredient.typeNumber.toString().split('.').last.substring(0, 1)}',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Add Item Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                // Logic for adding a new ingredient
                addItem();
              },
              child: Container(
                height: 430,
                width: 300,
                decoration: BoxDecoration(
                  color: backgroundColor2,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
