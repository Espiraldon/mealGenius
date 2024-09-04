import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/models/content.dart';
import 'package:mealgenius/src/screens/private/Ingredients_screen.dart';
import 'package:mealgenius/src/screens/private/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/data.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/recipe_widget.dart';

class recipeScreen extends StatefulWidget {
  final Function(int) onItemtap;

  const recipeScreen({required this.onItemtap, super.key});

  @override
  State<recipeScreen> createState() => _recipeScreenState();
}

class _recipeScreenState extends State<recipeScreen> {
  List<Color> colorbar = [
    tipo,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
  // ignore: unused_field
  int _selectindex = 0;
  void _onItemTapped(
    int index,
  ) {
    setState(() {
      _selectindex = index;
      if (index == 0) {
        colorbar = [
          tipo,
          Colors.grey,
          Colors.grey,
          Colors.grey,
        ];
      } else if (index == 1) {
        colorbar = [
          Colors.grey,
          tipo,
          Colors.grey,
          Colors.grey,
        ];
      }
    });
  }

  void createrecipe() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog.fullscreen(
              backgroundColor: backgroundColor,
              child: const AddrecipeWidget(),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('value'),
      resizeDuration: const Duration(milliseconds: 1),
      background: const HomeScreen(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.onItemtap(0);
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppbar(
          title: 'recipe',
          leading: IconButton(
              onPressed: () => widget.onItemtap(0),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'All recipe',
                      style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SearchBar(
                    backgroundColor: MaterialStatePropertyAll(backgroundColor2),
                    hintText: 'Search recipe',
                    textStyle: MaterialStatePropertyAll(
                        GoogleFonts.lato(color: Colors.grey, fontSize: 15)),
                    leading: const Icon(Icons.search_outlined),
                  ),
                  Row(
                    children: [
                      ActionBar(
                        index: 0,
                        title: 'By origines',
                        colors: colorbar,
                        onItemtap: _onItemTapped,
                      ),
                      ActionBar(
                        index: 1,
                        title: 'By field',
                        colors: colorbar,
                        onItemtap: _onItemTapped,
                      ),
                    ],
                  ),
                  recipeListWidget(recipes: myrecipe),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () => createrecipe(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: primaryColor),
                      child: Text(
                        'Create new recipe',
                        style: GoogleFonts.lato(color: backgroundColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class recipeListWidget extends StatefulWidget {
  final List<recipeContent> recipes;
  const recipeListWidget({required this.recipes, super.key});

  @override
  State<recipeListWidget> createState() => _recipeListWidgetState();
}

class _recipeListWidgetState extends State<recipeListWidget> {
  @override
  Widget build(BuildContext context) {
    void _onItemtap(recipeContent recipe) {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog.fullscreen(
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: CustomAppbar(
                    titleWidget: Text(
                      recipe.title,
                      style: GoogleFonts.lato(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: tipo),
                    ),
                    leading: CloseButton(
                      onPressed: () => setState(() {
                        Navigator.pop(context);
                      }),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SafeArea(
                        child: ReceipeWidget(
                          recipe: recipe,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      });
    }

    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: backgroundColor2,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final recipeContent recipe = widget.recipes[index];
          return Stack(
            children: [
              Dismissible(
                key: Key(recipe.title),
                background: Container(
                  color: negative,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      widget.recipes.removeAt(index);
                    });
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: ClipOval(
                              child: Image.network(recipe.recipeImage),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              recipe.title,
                              style: GoogleFonts.lato(color: tipo),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _onItemtap(recipe),
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: const Icon(
                            Icons.menu,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 2,
                  width: 500,
                  color: Colors.grey,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class AddrecipeWidget extends StatefulWidget {
  const AddrecipeWidget({super.key});

  @override
  State<AddrecipeWidget> createState() => _AddrecipeWidgetState();
}

class _AddrecipeWidgetState extends State<AddrecipeWidget> {
  @override
  Widget build(BuildContext context) {
    recipeContent newrecipe = recipeContent(ingredients: []);

    NumberType Selectoption = NumberType.Grammes;

    IngredientType Selectoption2 = IngredientType.dairyProducts;
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
    List<NumberType> typeNumber = [
      NumberType.Grammes,
      NumberType.Litre,
      NumberType.Pieces
    ];
    void addItem() {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              IngredientContent newIgredient =
                  IngredientContent(expirationDate: DateTime(2023, 8, 30));
              newIgredient.type = Selectoption2;
              newIgredient.typeNumber = Selectoption;

              return Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  bottom: 85,
                ),
                child: SingleChildScrollView(
                  child: AlertDialog(
                    titlePadding: const EdgeInsets.only(left: 50, top: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Add Ingredients',
                        style: GoogleFonts.lato(
                            color: tipo,
                            fontSize: 25,
                            fontWeight: FontWeight.w800)),
                    content: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            newIgredient.name = value;
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
                        DropdownButton(
                            value: Selectoption2,
                            items: type.map((IngredientType typeNum) {
                              return DropdownMenuItem(
                                  value: typeNum,
                                  child: Text(
                                    typeNum
                                            .toString()
                                            .split('.')
                                            .last
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        typeNum
                                            .toString()
                                            .split('.')
                                            .last
                                            .substring(1)
                                            .toLowerCase(),
                                    style: GoogleFonts.lato(color: tipo),
                                  ));
                            }).toList(),
                            onChanged: (IngredientType? value) => setState(() {
                                  Selectoption2 = value!;
                                  newIgredient.type = Selectoption2;
                                })),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            newIgredient.cal = double.parse(value);
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'Energy value (kcal)',
                              style: GoogleFonts.lato(
                                  color: tipo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            newIgredient.number = int.parse(value);
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'number',
                              style: GoogleFonts.lato(
                                  color: tipo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        DropdownButton(
                            value: Selectoption,
                            items: typeNumber.map((NumberType typeNum) {
                              return DropdownMenuItem(
                                  value: typeNum,
                                  child: Text(
                                    typeNum.toString().split('.').last,
                                    style: GoogleFonts.lato(color: tipo),
                                  ));
                            }).toList(),
                            onChanged: (NumberType? value) {
                              setState(() {
                                Selectoption = value!;
                                newIgredient.typeNumber = NumberType.Grammes;
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor),
                          ),
                          onPressed: () async {
                            final imagePicker = ImagePicker();
                            final image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              newIgredient.ingredientImage = image.path;
                            }
                          },
                          child: Text(
                            'Select an image',
                            style: GoogleFonts.lato(
                                color: tipo,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      FloatingActionButton(
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: tipo,
                        ),
                      ),
                      TextButton(
                          onPressed: () => setState(() {
                                ingredientsKnown.add(newIgredient.copy());
                                newrecipe.ingredients.add(newIgredient.copy());
                                Navigator.of(context).pop();
                              }),
                          child: Text(
                            'Validate',
                            style: GoogleFonts.lato(
                                color: tipo,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                ),
              );
            });
      });
    }

    void changeParam() {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog.fullscreen(
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: CustomAppbar(
                      leading: BackButton(
                    onPressed: () => Navigator.pop(context),
                  )),
                  body: SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: newrecipe.title,
                            onChanged: (String title) => setState(() {
                              newrecipe.title = title;
                            }),
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
                          TextFormField(
                            initialValue: newrecipe.cost,
                            onChanged: (String cost) => setState(() {
                              newrecipe.cost = cost;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Cost',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue: newrecipe.calories,
                            onChanged: (String calories) => setState(() {
                              newrecipe.calories = calories;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Calories',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue: newrecipe.glucides,
                            onChanged: (String glucides) => setState(() {
                              newrecipe.glucides = glucides;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Glucides',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue: newrecipe.lipides,
                            onChanged: (String lipides) => setState(() {
                              newrecipe.lipides = lipides;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Lipides',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue: newrecipe.proteines,
                            onChanged: (String proteines) => setState(() {
                              newrecipe.proteines = proteines;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Proteines',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            initialValue: newrecipe.time,
                            onChanged: (String calories) => setState(() {
                              newrecipe.time = calories;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'Preparetion time',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                          TextFormField(
                            initialValue: newrecipe.recipe,
                            onChanged: (String calories) => setState(() {
                              newrecipe.recipe = calories;
                            }),
                            decoration: InputDecoration(
                              label: Text(
                                'recipe',
                                style: GoogleFonts.lato(
                                    color: tipo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              );
            });
      });
    }

    return Dismissible(
      key: const Key('value'),
      resizeDuration: const Duration(milliseconds: 1),
      background: recipeScreen(
        onItemtap: (index) => setState(() {}),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        appBar: CustomAppbar(
          leading: CloseButton(
            onPressed: () => Navigator.pop(context),
          ),
          titleWidget: Text(newrecipe.title,
              style: GoogleFonts.lato(
                  fontSize: 17, fontWeight: FontWeight.w700, color: tipo)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(children: [
                    SizedBox(
                      height: 275,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: newrecipe.recipeImage == ""
                                  ? IconButton(
                                      icon: const Icon(Icons.image),
                                      onPressed: () async {
                                        final imagePicker = ImagePicker();
                                        final image =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        if (image != null) {
                                          newrecipe.recipeImage = image.path;
                                        }
                                      })
                                  : Image.network(newrecipe.recipeImage))),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => changeParam(),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: primaryColor,
                            child: const Icon(Icons.menu),
                          ),
                        ))
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                  child: SizedBox(
                    height: 285,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newrecipe.ingredients.length,
                              itemBuilder: (BuildContext context, int index) {
                                final IngredientContent ingredient =
                                    newrecipe.ingredients[index];
                                return Stack(children: [
                                  Dismissible(
                                    key: Key(ingredient.name),
                                    background: Container(
                                      color: negative,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 16),
                                      child: const Icon(Icons.delete),
                                    ),
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        setState(() {
                                          newrecipe.ingredients.removeAt(index);
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: backgroundColor2,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 12,
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: backgroundColor2,
                                        child: Image.network(
                                            ingredient.ingredientImage),
                                      )),
                                  Positioned(
                                    top: 15,
                                    left: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ingredient.name,
                                          style: GoogleFonts.lato(
                                              color: tipo,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${ingredient.number} ${ingredient.typeNumber}',
                                          style: GoogleFonts.lato(
                                              color: tipo,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 20,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          Text(
                                            '${ingredient.cal} kcal',
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 2,
                                      width: 500,
                                      color: Colors.grey,
                                    ),
                                  )
                                ]);
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => addItem(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: primaryColor),
                              child: Icon(
                                Icons.add,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      Navigator.pop(context);
                      myrecipe.add(newrecipe);
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: primaryColor),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.lato(color: backgroundColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
