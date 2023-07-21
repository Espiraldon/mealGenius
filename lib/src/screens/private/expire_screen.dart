// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/screens/private/Ingredients_screen.dart';

import '../../widget/custom_appbar.dart';
import 'home_screen.dart';

class ExpireScreen extends StatefulWidget {
  final Function(int) onItemtap;
  const ExpireScreen({required this.onItemtap, super.key});

  @override
  State<ExpireScreen> createState() => _ExpireScreenState();
}

class _ExpireScreenState extends State<ExpireScreen> {
  List<Widget> SelectWidget = [
    ExpirationWidget(ingredientList: myIngredients),
    ExpirationbyFieldWidget(ingredientList: myIngredients)
  ];
  List<Color> colorbar = [
    tipo,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
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
          title: 'Expiration',
          leading: IconButton(
              onPressed: () => widget.onItemtap(0),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'All products',
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
                      backgroundColor:
                          MaterialStatePropertyAll(backgroundColor2),
                      hintText: 'Search product',
                      textStyle: MaterialStatePropertyAll(
                          GoogleFonts.lato(color: Colors.grey, fontSize: 15)),
                      leading: const Icon(Icons.search_outlined),
                      onChanged: (value) => setState(() {
                        print('$value');
                      }),
                    ),
                    Row(
                      children: [
                        ActionBar(
                          index: 0,
                          title: 'By expiration date',
                          colors: colorbar,
                          onItemtap: _onItemTapped,
                          leading: Icon(
                            Icons.calendar_month,
                            color: colorbar[0],
                          ),
                        ),
                        ActionBar(
                          index: 1,
                          title: 'By field',
                          colors: colorbar,
                          onItemtap: _onItemTapped,
                          leading: Icon(
                            Icons.list,
                            color: colorbar[1],
                          ),
                        ),
                      ],
                    ),
                    SelectWidget[_selectindex],
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpirationbyFieldWidget extends StatefulWidget {
  List<IngredientContent> ingredientList;
  ExpirationbyFieldWidget({required this.ingredientList, super.key});

  @override
  State<ExpirationbyFieldWidget> createState() =>
      _ExpirationbyFieldWidgetState();
}

class _ExpirationbyFieldWidgetState extends State<ExpirationbyFieldWidget> {
  late List<bool> _show;
  void initState() {
    super.initState();
    _show = List.filled(7, true);
  }

  @override
  Widget build(BuildContext context) {
    void _expireDisplay(int index) {
      setState(() {
        _show[index] = !_show[index];
      });
    }

    widget.ingredientList.sort(((a, b) {
      int typeComparaison = a.type.toString().compareTo(b.type.toString());
      if (typeComparaison != 0) {
        return typeComparaison;
      } else {
        return a.name.compareTo(b.name);
      }
    }));
    IngredientType test = widget.ingredientList[0].type;
    List<int> showindex = List.filled(widget.ingredientList.length, 0);
    int count = 0;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.ingredientList.length,
        itemBuilder: (BuildContext context, int index) {
          final IngredientContent ingredient = widget.ingredientList[index];
          bool newtype = false;
          int Daysbefore =
              ingredient.expirationDate.difference(DateTime.now()).inDays + 1;
          double expireTimePercent = 1 - Daysbefore / 10;

          if (test != ingredient.type) {
            test = ingredient.type;
            newtype = true;
            count++;
          } else if (index == 0) {
            test = ingredient.type;
            newtype = true;
          }
          showindex[index] = count;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newtype == true && ingredient.number != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              ingredient.type
                                      .toString()
                                      .split('.')
                                      .last
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  ingredient.type
                                      .toString()
                                      .split('.')
                                      .last
                                      .substring(1)
                                      .toLowerCase(),
                              style: GoogleFonts.lato(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: tipo),
                            ),
                          ),
                          _show[showindex[index]] == true
                              ? IconButton(
                                  onPressed: () =>
                                      _expireDisplay(showindex[index]),
                                  icon: Icon(
                                    const IconData(
                                      0xf13d,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    size: 30,
                                    color: tipo,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () =>
                                      _expireDisplay(showindex[index]),
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                  ),
                                )
                        ])
                  : const SizedBox(),
              _show[showindex[index]] == true && ingredient.number != 0
                  ? Dismissible(
                      key: Key(widget.ingredientList[index].name),
                      background: Container(
                        color: negative,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: tipo,
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            widget.ingredientList[index].number == 0;
                            myIngredients
                                .firstWhere((element) =>
                                    element.name == ingredient.name)
                                .number = 0;
                            expiredIngredients.removeWhere(
                                (element) => element.name == ingredient.name);
                          });
                        }
                      },
                      child: Stack(children: [
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: backgroundColor2),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Row(
                              children: [
                                Stack(alignment: Alignment.center, children: [
                                  CircularProgressIndicator(
                                    value: expireTimePercent,
                                    color: primaryColor,
                                    backgroundColor: const Color.fromARGB(
                                        255, 197, 191, 191),
                                  ),
                                  expireTimePercent >= 1
                                      ? Text(
                                          '!',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: negative),
                                        )
                                      : Text(
                                          '$Daysbefore J',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                              color: primaryColor),
                                        ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0, bottom: 3, left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ingredient.name,
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: tipo,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            const IconData(0xf7e7,
                                                fontFamily:
                                                    CupertinoIcons.iconFont,
                                                fontPackage: CupertinoIcons
                                                    .iconFontPackage),
                                            size: 20,
                                            color: neutral,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '- ${ingredient.name}',
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          child: Row(
                            children: [
                              Text(
                                '${ingredient.number} ${ingredient.typeNumber}',
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        )
                      ]),
                    )
                  : const SizedBox(),
            ],
          );
        });
  }
}

class ExpirationWidget extends StatefulWidget {
  List<IngredientContent> ingredientList;
  ExpirationWidget({required this.ingredientList, super.key});

  @override
  State<ExpirationWidget> createState() => _ExpirationWidgetState();
}

class _ExpirationWidgetState extends State<ExpirationWidget> {
  late List<bool> _show;
  List<String> title = [
    'Expired !',
    '3 Days before !',
    '5 Days before !',
    '1 week or more'
  ];
  @override
  void initState() {
    super.initState();
    _show = List.filled(title.length, true);
  }

  @override
  Widget build(BuildContext context) {
    void _expireDisplay(int index) {
      setState(() {
        _show[index] = !_show[index];
      });
    }

    List<int> titleindex = List.filled(widget.ingredientList.length, 0);
    widget.ingredientList
        .sort((a, b) => b.expirationDate.compareTo(a.expirationDate));
    widget.ingredientList = List.from(widget.ingredientList.reversed);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.ingredientList.length,
      itemBuilder: (BuildContext context, int index) {
        final IngredientContent ingredient = widget.ingredientList[index];
        int Daysbefore =
            ingredient.expirationDate.difference(DateTime.now()).inDays + 1;
        double expireTimePercent = 1 - Daysbefore / 10;
        if (Daysbefore <= 0) {
          titleindex[index] = 0;
        } else if (Daysbefore >= 1 && Daysbefore <= 3) {
          titleindex[index] = 1;
        } else if (Daysbefore >= 3 && Daysbefore <= 5) {
          titleindex[index] = 2;
        } else {
          titleindex[index] = 3;
        }

        if (ingredient.name != '') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (index == 0 || titleindex[index - 1] != titleindex[index]) &&
                      ingredient.number != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              title[titleindex[index]],
                              style: GoogleFonts.lato(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: tipo),
                            ),
                          ),
                          _show[titleindex[index]] == true
                              ? IconButton(
                                  onPressed: () =>
                                      _expireDisplay(titleindex[index]),
                                  icon: Icon(
                                    const IconData(
                                      0xf13d,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    size: 30,
                                    color: tipo,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () =>
                                      _expireDisplay(titleindex[index]),
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                  ),
                                )
                        ])
                  : const SizedBox(),
              _show[titleindex[index]] == true && ingredient.number != 0
                  ? Dismissible(
                      key: Key(ingredient.name),
                      background: Container(
                        color: negative,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: tipo,
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            widget.ingredientList[index].number == 0;
                            myIngredients
                                .firstWhere((element) =>
                                    element.name == ingredient.name)
                                .number = 0;
                            expiredIngredients.removeWhere(
                                (element) => element.name == ingredient.name);
                          });
                        }
                      },
                      child: Stack(children: [
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: backgroundColor2),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Row(
                              children: [
                                Stack(alignment: Alignment.center, children: [
                                  CircularProgressIndicator(
                                    value: expireTimePercent,
                                    color: primaryColor,
                                    backgroundColor: const Color.fromARGB(
                                        255, 197, 191, 191),
                                  ),
                                  expireTimePercent >= 1
                                      ? Text(
                                          '!',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: negative),
                                        )
                                      : Text(
                                          '$Daysbefore J',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                              color: primaryColor),
                                        ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0, bottom: 3, left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ingredient.name,
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: tipo,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            const IconData(0xf7e7,
                                                fontFamily:
                                                    CupertinoIcons.iconFont,
                                                fontPackage: CupertinoIcons
                                                    .iconFontPackage),
                                            size: 20,
                                            color: neutral,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '- ${ingredient.name}',
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          child: Row(
                            children: [
                              Text(
                                '${ingredient.number} ${ingredient.typeNumber}',
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        )
                      ]),
                    )
                  : const SizedBox(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
