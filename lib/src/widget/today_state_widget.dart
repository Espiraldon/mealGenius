// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/widget/custom_appbar.dart';
import '../data/data.dart';
import 'package:food_icons/food_icons.dart';
import '../widget/receipe_widget.dart';
import 'daily_consume_widget.dart';
import 'money_widget.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  late int _currentSlide;
  @override
  void initState() {
    super.initState();
    todayReicipe = weekday[currentday - 1];
    _currentSlide = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselWidget = [
      const DailyConsumeWidget(),
      const DayMoneySpentWidget(),
    ];
    Widget buildIndicators() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselWidget.map((e) {
            int index = carouselWidget.indexOf(e);
            return Container(
              width: 8.0,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentSlide == index ? tipo : backgroundColor,
                  border: Border.all(color: tipo)),
            );
          }).toList());
    }

    return SingleChildScrollView(
      child: SafeArea(

        
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                    itemCount: carouselWidget.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return carouselWidget[index];
                    },
                    options: CarouselOptions(
                      height: 250,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 0.95,
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                buildIndicators(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Menu',
                    style: GoogleFonts.lato(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                MenuWidget(
                  reicipe: todayReicipe,
                  backgroundcolor: backgroundColor2,
                ),
              ]),
        ),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  List<ReicipeContent>? reicipe;
  Color backgroundcolor;
  MenuWidget({required this.backgroundcolor, required this.reicipe, super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late List<MenuClass> menulist;
  void init() {
    menulist = <MenuClass>[
      MenuClass(
          name: 'Break feast',
          icon: Icons.coffee,
          max: 600,
          realised: int.parse(widget.reicipe![0].calories),
          reicipe: widget.reicipe![0]),
      MenuClass(
          name: 'Lunch',
          icon: FoodIcons.wisk,
          max: 800,
          realised: int.parse(widget.reicipe![1].calories),
          reicipe: widget.reicipe![1]),
      MenuClass(
          name: 'Dinner',
          icon: FoodIcons.bowl,
          max: 600,
          realised: int.parse(widget.reicipe![2].calories),
          reicipe: widget.reicipe![2]),
      MenuClass(
          name: 'Snack',
          icon: FoodIcons.oven,
          max: 40,
          realised: int.parse(widget.reicipe![3].calories),
          reicipe: widget.reicipe![3])
    ];
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void onItemtap(MenuClass menu, int index) {
    setState(
      () {
        String change = myReicipe[0].title;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return menu.reicipe == null ||
                      menu.reicipe!.title == 'New reicipe'
                  ? AlertDialog(
                      title: Text(
                        'Add reicipe',
                        style: GoogleFonts.lato(),
                      ),
                      content: SingleChildScrollView(
                        child: SafeArea(
                            child: Column(
                          children: [
                            DropdownButton(
                                value: change,
                                items: myReicipe.map((ReicipeContent e) {
                                  return DropdownMenuItem(
                                      value: e.title,
                                      child: Text(
                                        e.title,
                                        style: GoogleFonts.lato(color: tipo),
                                      ));
                                }).toList(),
                                onChanged: (String? e) => setState(() {
                                      change = e!;
                                    })),
                            TextButton(
                                onPressed: () => setState(() {
                                      widget.reicipe![index] =
                                          myReicipe.firstWhere((element) =>
                                              element.title == change);
                                      init();
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
                        )),
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
                      ],
                    )
                  : Dialog.fullscreen(
                      child: Scaffold(
                      appBar: CustomAppbar(
                        titleWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(menu.icon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              menu.name,
                              style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: tipo),
                            ),
                          ],
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
                              reicipe: menu.reicipe!,
                            ),
                          ),
                        ),
                      ),
                    ));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: widget.backgroundcolor,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menulist.length,
          itemBuilder: (BuildContext context, int index) {
            final MenuClass menu = menulist[index];
            return Stack(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: widget.backgroundcolor,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 20,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: menu.realised / menu.max,
                        color: primaryColor,
                        backgroundColor: Colors.grey,
                      ),
                      Icon(
                        menu.icon,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style: GoogleFonts.lato(
                            color: tipo, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '${menu.realised}/${menu.max} kcal',
                        style: GoogleFonts.lato(
                            color: tipo,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 15,
                    top: 15,
                    child: GestureDetector(
                      onTap: () => onItemtap(menu, index),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: primaryColor,
                        child: menu.reicipe == null ||
                                menu.reicipe!.title == 'New reicipe'
                            ? Icon(
                                Icons.add,
                                color: backgroundColor,
                              )
                            : Icon(
                                Icons.menu,
                                color: backgroundColor,
                              ),
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
