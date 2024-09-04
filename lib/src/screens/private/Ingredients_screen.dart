// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/content.dart';
import 'package:mealgenius/src/widget/custom_appbar.dart';
import 'package:mealgenius/src/widget/ingredient_widget.dart';

import 'home_screen.dart';

class IngredientsManageScreeen extends StatefulWidget {
  final Function(int) onItemtap;
  const IngredientsManageScreeen({required this.onItemtap, super.key});

  @override
  State<IngredientsManageScreeen> createState() =>
      _IngredientsManageScreeenState();
}

class _IngredientsManageScreeenState extends State<IngredientsManageScreeen> {
  int _selectindex = 0;

  List<Widget> widgetlist = [
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.fruit)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.vegetable)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.meat)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.fish)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.carbohydrate)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.legume)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.pasta)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.boisson)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.feculent)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.salsa)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.dairyProducts)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.other)
          .toList(),
    ),
  ];
  List<String> listTitle = [
    'fruit',
    'vegetable',
    'meat',
    'fish',
    'carbohydrate',
    'legume',
    'pasta',
    'boisson',
    'feculent',
    'salsa',
    'dairyProducts',
    'other'
  ];

  List<Color> colorbar = List.generate(12, (index) => Colors.grey);

  void _onItemTapped(int index) {
    setState(() {
      _selectindex = index;

      // Réinitialiser toutes les couleurs à gris
      colorbar = List.generate(listTitle.length, (i) => Colors.grey);

      // Appliquer la couleur 'tipo' à l'index sélectionné
      colorbar[index] = tipo;
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
        appBar: CustomAppbar(
          title: 'Ingredients',
          leading: IconButton(
              onPressed: () => widget.onItemtap(0),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < listTitle.length; i++)
                          ActionBar(
                              index: i,
                              title: listTitle[i],
                              colors: colorbar,
                              onItemtap: _onItemTapped),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                widgetlist[_selectindex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionBar extends StatefulWidget {
  final Function(int) onItemtap;
  final List<Color> colors;
  final String title;
  final int index;
  Widget? leading;
  ActionBar(
      {this.leading,
      required this.index,
      required this.title,
      required this.colors,
      required this.onItemtap,
      super.key});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onItemtap(widget.index),
        child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 20,
              top: 10,
            ),
            child: widget.leading != null
                ? Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: backgroundColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.leading!,
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(widget.title,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: widget.colors[widget.index])),
                        )
                      ],
                    ))
                : Text(widget.title,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: widget.colors[widget.index]))));
  }
}
