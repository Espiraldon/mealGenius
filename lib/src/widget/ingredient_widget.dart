import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/models/content.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
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
  String Selectoption = 'Grammes';
  List<String> typeNumber = ['Grammes', 'Pieces'];
  IngredientType Selectoption2 = IngredientType.dairyProducts;
  List<IngredientType> type = [
    IngredientType.dairyProducts,
    IngredientType.feculent,
    IngredientType.fruit,
    IngredientType.meal,
    IngredientType.other,
    IngredientType.salsa,
    IngredientType.vegetable
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
                          newIgredient.cal = int.parse(value);
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
                          items: typeNumber.map((String typeNum) {
                            return DropdownMenuItem(
                                value: typeNum,
                                child: Text(
                                  typeNum,
                                  style: GoogleFonts.lato(color: tipo),
                                ));
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              Selectoption = value!;
                              newIgredient.typeNumber = Selectoption;
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
                              myIngredients.add(newIgredient.copy());
                              ingredientsKnown.add(newIgredient.copy());
                              widget.ingredientItems!.add(newIgredient.copy());

                              Navigator.of(context).pop();
                            }),
                        child: Text(
                          'Submit',
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
                IngredientContent Fruits = widget.ingredientItems![index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  child: Dismissible(
                    key: Key(Fruits.name),
                    direction: DismissDirection.vertical,
                    background: Container(
                      color: negative,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Icon(
                        Icons.delete,
                        color: tipo,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.vertical) {
                        setState(() {
                          myIngredients.removeWhere(
                              (element) => element.name == Fruits.name);
                        });
                      }
                    },
                    child: Container(
                      height: 430,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          color: primaryColor),
                      child: Stack(children: [
                        Positioned(
                          left: 40,
                          top: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(Fruits.name,
                                  style: GoogleFonts.lato(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: tipo,
                                  )),
                              Text(
                                '${Fruits.cal} kcal',
                                style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: tipo),
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
                                    image: AssetImage(Fruits.ingredientImage),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => setState(() {
                              Fruits.number = Fruits.number + 1;
                            }),
                            child: Container(
                              height: 90,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: positive,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 20,
                            bottom: 20,
                            child: Text(
                              '${Fruits.number} ${Fruits.typeNumber.toString().split('.').last.substring(0, 1).toUpperCase()}',
                              style: GoogleFonts.lato(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                color: tipo,
                              ),
                            )),
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () => addItem(),
              child: Container(
                height: 430,
                width: 300,
                decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: tipo,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
