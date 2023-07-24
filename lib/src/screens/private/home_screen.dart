import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/screens/private/Ingredients_screen.dart';
import 'package:happly/src/screens/private/expire_screen.dart';
import 'package:happly/src/screens/private/reicipe_screen.dart';
import 'package:happly/src/screens/private/shoplist_screen.dart';
import 'package:happly/src/widget/dashboard_containers.dart';
import 'package:happly/src/widget/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:happly/src/widget/global_view_widget.dart';
import 'package:happly/src/widget/money_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectindex = 0;
  final List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    widgets.addAll([
      Firstscreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      IngredientsManageScreeen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ExpireScreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ReicipeScreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ShoplistScreeen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: widgets.elementAt(_selectindex),
        ),
      ),
    );
  }
}

class Firstscreen extends StatefulWidget {
  final Function(int) onItemtap;
  const Firstscreen({required this.onItemtap, super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  late int _currentSlide;
  @override
  void initState() {
    super.initState();
    _currentSlide = 0;
  }

  @override
  Widget build(BuildContext context) {
    expiredIngredients = myIngredients
        .where((element) =>
            element.expirationDate.difference(DateTime.now()).inDays <= 0)
        .toList();

    List<Widget> carouselWidget = [
      const GlobalViewWidget(),
      const DayMoneySpentWidget(),
      WeekMoneySpentWidget(
        currentday: currentday - 1,
      ),
      const MonthMoneySpentWidget()
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

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(
        title: "MealGenius",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(
                  leading: const Icon(Icons.search),
                  hintStyle: MaterialStatePropertyAll(
                      GoogleFonts.lato(color: Colors.grey)),
                  hintText: 'What are you searching for ?',
                  backgroundColor: MaterialStatePropertyAll(backgroundColor2),
                ),
                const _titletext(
                  title: 'Statistiques',
                  isSubtitle: true,
                ),
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
                const _titletext(
                  title: 'Meal Management',
                  isSubtitle: true,
                ),
                Dashboard(
                  reicipenumber: '${myReicipe.length}',
                  expirenumber: '${expiredIngredients.length}',
                  ingredientnumber: '${myIngredients.length}',
                  shopnumber: '${myShopList.length}',
                  onchangedstep: widget.onItemtap,
                ),
              ]),
        ),
      ),
    );
  }
}

class _titletext extends StatelessWidget {
  final String title;
  final bool isSubtitle;
  const _titletext({required this.title, this.isSubtitle = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(title,
          style: isSubtitle
              ? GoogleFonts.lato(
                  color: tipo, fontWeight: FontWeight.w900, fontSize: 24)
              : GoogleFonts.lato(
                  fontSize: 20, fontWeight: FontWeight.w400, color: tipo)),
    );
  }
}
