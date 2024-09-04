// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/content.dart';

class ReceipeWidget extends StatefulWidget {
  recipeContent recipe;
  ReceipeWidget({required this.recipe, super.key});

  @override
  State<ReceipeWidget> createState() => _ReceipeWidgetState();
}

class _ReceipeWidgetState extends State<ReceipeWidget> {
  void ontap() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: backgroundColor,
              titlePadding: const EdgeInsets.only(left: 50, top: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                'recipe',
                style:
                    GoogleFonts.lato(color: tipo, fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.recipe.recipe,
                      style: GoogleFonts.lato(color: tipo),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 275,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(widget.recipe.recipeImage))),
              ),
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () => ontap(),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: primaryColor,
                      child: const Icon(Icons.menu),
                    ),
                  )),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 90,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      widget.recipe.time,
                      style: GoogleFonts.lato(
                        color: tipo,
                      ),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Container(
                  height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Information(
                          name: 'Calories',
                          number: double.parse(widget.recipe.calories),
                          type: 'kcal'),
                      _Information(
                          name: 'Glucides',
                          number: double.parse(widget.recipe.glucides),
                          type: 'g'),
                      _Information(
                          name: 'Proteines',
                          number: double.parse(widget.recipe.proteines),
                          type: 'g'),
                      _Information(
                          name: 'Lipides',
                          number: double.parse(widget.recipe.lipides),
                          type: 'g')
                    ],
                  ),
                ),
              ],
            ),
          ),
          _IngredientListView(
            Ingredientlist: widget.recipe.ingredients,
          )
        ],
      ),
    );
  }
}

class _IngredientListView extends StatefulWidget {
  final List<IngredientContent> Ingredientlist;
  const _IngredientListView({required this.Ingredientlist});

  @override
  State<_IngredientListView> createState() => __IngredientListViewState();
}

class __IngredientListViewState extends State<_IngredientListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: backgroundColor2,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.Ingredientlist.length,
          itemBuilder: (BuildContext context, int index) {
            final IngredientContent ingredient = widget.Ingredientlist[index];
            return Stack(children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: backgroundColor2,
                ),
              ),
              Positioned(
                  top: 12,
                  left: 20,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: backgroundColor2,
                    child: Image.network(ingredient.ingredientImage),
                  )),
              Positioned(
                top: 15,
                left: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        style:
                            GoogleFonts.lato(fontSize: 15, color: Colors.grey),
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
    );
  }
}

class _Information extends StatelessWidget {
  final String name;
  final double number;
  final String type;
  const _Information(
      {required this.name, required this.type, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$number $type',
          style: GoogleFonts.lato(
              fontSize: 17, color: tipo, fontWeight: FontWeight.w900),
        ),
        Text(
          name,
          style: GoogleFonts.lato(fontSize: 15, color: tipo),
        )
      ],
    );
  }
}
