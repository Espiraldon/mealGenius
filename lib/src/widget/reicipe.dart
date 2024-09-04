import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';
import '../models/content.dart';

class recipe extends StatelessWidget {
  final recipeContent recipes;
  const recipe({required this.recipes, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor2,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomRight, children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: positive,
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(recipes.recipeImage))),
            ),
            Container(
              alignment: Alignment.center,
              height: 20,
              width: 90,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Text(
                recipes.time,
                style: GoogleFonts.lato(
                  color: tipo,
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  recipes.title,
                  style: GoogleFonts.lato(
                      color: tipo, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_sharp,
                      size: 18,
                      color: positive,
                    ),
                    Text(
                      " ${recipes.cost} €",
                      style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  "${recipes.calories} kcal",
                  style: GoogleFonts.lato(
                    color: negative,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
