import 'package:flutter/material.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/screens/private/daily_screen.dart';
import 'package:happly/src/screens/private/home_screen.dart';
import 'package:happly/src/screens/private/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectindex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    const HomeScreen(),
    const DailyScreen(),
    const Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          child: _widgetOption[_selectindex],
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "diary",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "profile",
          ),
        ],
        currentIndex: _selectindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: tipo,
        unselectedItemColor: const Color.fromARGB(255, 106, 96, 96),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }
}
