import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/widget/custom_appbar.dart';
import '../data/data.dart';
import 'package:food_icons/food_icons.dart';
import '../widget/receipe_widget.dart';
import 'daily_consume_widget.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DailyConsumeWidget(),
                MoneySpentWidget(),
                MenuWidget(),
              ]),
        ),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  List<MenuClass> menulist = <MenuClass>[
    MenuClass(
        name: 'Break feast',
        icon: Icons.coffee,
        max: 200,
        realised: 60,
        reicipe: pasta2),
    MenuClass(name: 'Lunch', icon: FoodIcons.wisk, max: 200, realised: 60),
    MenuClass(name: 'Dinner', icon: FoodIcons.bowl, max: 100, realised: 50),
    MenuClass(name: 'Snack', icon: FoodIcons.oven, max: 40, realised: 0)
  ];
  void onItemtap(MenuClass menu) {
    setState(
      () {
        String change = myReicipe[0].title;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return menu.reicipe == null
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
                                      menu.reicipe = myReicipe.firstWhere(
                                          (element) => element.title == change);
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
          color: backgroundColor,
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
                    color: backgroundColor2,
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
                      onTap: () => onItemtap(menu),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: primaryColor,
                        child: menu.reicipe == null
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

class MoneySpentWidget extends StatefulWidget {
  const MoneySpentWidget({super.key});

  @override
  State<MoneySpentWidget> createState() => _MoneySpentWidgetState();
}

class _MoneySpentWidgetState extends State<MoneySpentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: positive,
            ),
          ),
        ],
      ),
    );
  }
}
