// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/models/content.dart';

class ReceipeWidget extends StatefulWidget {
  ReicipeContent reicipe;
  ReceipeWidget({required this.reicipe, super.key});

  @override
  State<ReceipeWidget> createState() => _ReceipeWidgetState();
}

class _ReceipeWidgetState extends State<ReceipeWidget> {
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
                        child: Image.asset(widget.reicipe.reicipeImage))),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: primaryColor,
                    child: const Icon(Icons.menu),
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Information(name: 'Calories', number: 271, type: 'kcal'),
                      _Information(name: 'Glucides', number: 45.2, type: 'g'),
                      _Information(name: 'Proteines', number: 8.1, type: 'g'),
                      _Information(name: 'Lipides', number: 4.6, type: 'g')
                    ],
                  ),
                ),
              ],
            ),
          ),
          _IngredientListView(
            Ingredientlist: widget.reicipe.ingredients,
          )
        ],
      ),
    );
  }
}

class _IngredientListView extends StatefulWidget {
  final List<IngredientContent> Ingredientlist;
  const _IngredientListView({required this.Ingredientlist, super.key});

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
                    child: Image.asset(ingredient.ingredientImage),
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
      {required this.name,
      required this.type,
      required this.number,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${number} ${type}',
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
