import 'package:flutter/material.dart';
import 'package:mealgenius/src/models/ingredientcontent.dart';
export 'ingredientcontent.dart';
export 'recipecontent.dart';

class ProfileContent {
  final Icon contenticons;
  final String contenttitle;
  const ProfileContent({
    required this.contenticons,
    required this.contenttitle,
  });
}

class ShopListContent {
  Image image;
  String list;
  List<IngredientContent> product;
  ShopListContent({
    required this.image,
    required this.product,
    this.list = 'Shopping list',
  });
}
