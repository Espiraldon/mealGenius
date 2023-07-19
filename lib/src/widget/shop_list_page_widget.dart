// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/widget/custom_appbar.dart';

import '../data/data.dart';

class ShopListPageWidget extends StatefulWidget {
  ShopListContent list;
  ShopListPageWidget({required this.list, super.key});

  @override
  State<ShopListPageWidget> createState() => _ShopListPageWidgetState();
}

class _ShopListPageWidgetState extends State<ShopListPageWidget> {
  String? selectedOption = myIngredients[0].name;
  void _addIngredients() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Add ingredient',
                style: GoogleFonts.lato(
                    color: tipo, fontSize: 25, fontWeight: FontWeight.w800),
              ),
              content: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    value: selectedOption,
                    onChanged: (String? newValue) => setState(() {
                      selectedOption = newValue;
                    }),
                    items: myIngredients.map((IngredientContent ingredient) {
                      return DropdownMenuItem<String>(
                        value: ingredient.name,
                        child: Text(
                          ingredient.name,
                          style: GoogleFonts.lato(color: tipo),
                        ),
                      );
                    }).toList(),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          widget.list.product.any(
                                  (element) => element.name == selectedOption)
                              ? widget
                                  .list
                                  .product[widget.list.product.indexWhere(
                                      (element) =>
                                          element.name == selectedOption)]
                                  .number++
                              : widget.list.product.add(
                                  myIngredients.firstWhere((element) =>
                                      element.name == selectedOption));
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Submit',
                        style: GoogleFonts.lato(color: positive),
                      ))
                ],
              )),
              actions: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.close,
                      color: backgroundColor,
                    ),
                  ),
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        leading: CloseButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: widget.list.list,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 570,
                    width: double.infinity,
                    color: backgroundColor,
                  ),
                  IngredientShopListWidget(
                    ingredients: widget.list.product,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () => _addIngredients(),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.add,
                      color: backgroundColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class IngredientShopListWidget extends StatefulWidget {
  List<IngredientContent> ingredients;
  IngredientShopListWidget({required this.ingredients, super.key});

  @override
  State<IngredientShopListWidget> createState() =>
      _IngredientShopListWidgetState();
}

class _IngredientShopListWidgetState extends State<IngredientShopListWidget> {
  late IngredientType currentType;
  late List<bool> isbougthlist;
  late int? test;
  @override
  void initState() {
    super.initState();
    test = widget.ingredients.length;
    isbougthlist = List.filled(widget.ingredients.length, false);
    if (widget.ingredients.isNotEmpty) {
      currentType = widget.ingredients[0].type;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (test != widget.ingredients.length) {
      test = widget.ingredients.length;
      isbougthlist = List.filled(widget.ingredients.length, false);
      if (widget.ingredients.isNotEmpty) {
        currentType = widget.ingredients[0].type;
      }
    }
    widget.ingredients.sort(((a, b) {
      int typeComparaison = a.type.toString().compareTo(b.type.toString());
      if (typeComparaison != 0) {
        return typeComparaison;
      } else {
        return a.name.compareTo(b.name);
      }
    }));

    return widget.ingredients.isEmpty
        ? Positioned(
            bottom: 260,
            left: 24,
            child: Text(
              'This list is empty',
              style: GoogleFonts.lato(
                  color: tipo, fontWeight: FontWeight.w900, fontSize: 40),
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.ingredients.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                        child: Text(
                          widget.ingredients[index].type
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(0, 1)
                                  .toUpperCase() +
                              widget.ingredients[index].type
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(1)
                                  .toLowerCase(),
                          style: GoogleFonts.lato(
                              color: tipo, fontWeight: FontWeight.w600),
                        )),
                    IngredientsListsbyType(
                      index: index,
                      ingredients: widget.ingredients,
                      isbougthlist: isbougthlist,
                    )
                  ],
                );
              } else if (widget.ingredients[index].type != currentType) {
                currentType = widget.ingredients[index].type;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          widget.ingredients[index].type
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(0, 1)
                                  .toUpperCase() +
                              widget.ingredients[index].type
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(1)
                                  .toLowerCase(),
                          style: GoogleFonts.lato(
                              color: tipo, fontWeight: FontWeight.w600),
                        )),
                    IngredientsListsbyType(
                      index: index,
                      ingredients: widget.ingredients,
                      isbougthlist: isbougthlist,
                    )
                  ],
                );
              }
              return IngredientsListsbyType(
                index: index,
                ingredients: widget.ingredients,
                isbougthlist: isbougthlist,
              );
            });
  }
}

class IngredientsListsbyType extends StatefulWidget {
  List<bool> isbougthlist;
  List<IngredientContent> ingredients;
  int index;
  IngredientsListsbyType(
      {required this.ingredients,
      required this.isbougthlist,
      required this.index,
      super.key});

  @override
  State<IngredientsListsbyType> createState() => _IngredientsListsbyTypeState();
}

class _IngredientsListsbyTypeState extends State<IngredientsListsbyType> {
  @override
  Widget build(BuildContext context) {
    void _changeQuantity() {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              int num = 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text(
                    'Change number',
                    style: GoogleFonts.lato(
                        color: tipo, fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                  content: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => num = int.parse(value),
                        keyboardType: TextInputType.number,
                      ),
                      TextButton(
                          onPressed: () => setState(() {
                                Navigator.pop(context);
                                widget.ingredients[widget.index].number = num;
                              }),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.lato(
                              color: positive,
                            ),
                          ))
                    ],
                  ),
                ),
              );
            });
      });
    }

    return Stack(
      children: [
        const SizedBox(
          height: 60,
          width: double.infinity,
        ),
        widget.isbougthlist[widget.index] == true
            ? GestureDetector(
                onTap: () => setState(() {
                      widget.isbougthlist[widget.index] =
                          !widget.isbougthlist[widget.index];
                    }),
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      border: Border.all(color: backgroundColor2),
                      borderRadius: BorderRadius.circular(20),
                      color: backgroundColor2),
                  child: Icon(
                    Icons.check,
                    color: primaryColor,
                  ),
                ))
            : GestureDetector(
                onTap: () => setState(() {
                      widget.isbougthlist[widget.index] =
                          !widget.isbougthlist[widget.index];
                    }),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      border: Border.all(color: tipo),
                      borderRadius: BorderRadius.circular(16)),
                )),
        widget.isbougthlist[widget.index] == true
            ? Positioned(
                top: 8,
                left: 50,
                child: Text(
                  widget.ingredients[widget.index].name,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ))
            : Positioned(
                top: 8,
                left: 50,
                child: Text(
                  widget.ingredients[widget.index].name,
                  style: GoogleFonts.lato(fontSize: 18, color: tipo),
                )),
        Positioned(
            top: 15,
            right: 0,
            child: GestureDetector(
              onTap: () => _changeQuantity(),
              child: Text(
                  '${widget.ingredients[widget.index].number} ${widget.ingredients[widget.index].typeNumber}',
                  style: GoogleFonts.lato(fontSize: 15, color: Colors.grey)),
            )),
        Positioned(
            bottom: 10,
            child: Container(
              height: 2,
              width: 500,
              color: backgroundColor2,
            ))
      ],
    );
  }
}
