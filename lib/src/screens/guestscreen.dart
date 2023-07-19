import 'package:flutter/material.dart';
import 'package:happly/src/screens/public/auth.dart';
import 'package:happly/src/screens/public/CGU.dart';
import 'package:happly/src/screens/public/registration.dart';
import 'package:happly/src/screens/public/social_screen.dart';
import 'package:happly/src/screens/public/welcome_screen.dart';
import 'package:happly/src/screens/private/home.dart';

class GuestScreeen extends StatefulWidget {
  const GuestScreeen({super.key});

  @override
  State<GuestScreeen> createState() => _GuestScreeenState();
}

class _GuestScreeenState extends State<GuestScreeen> {
  final List<Widget> _widgets = [];
  int _indexSelected = 0;
  @override
  void initState() {
    super.initState();
    _widgets.addAll([
      WelcomeScreen(
          onChangedStep: (index) => setState(() {
                _indexSelected = index;
              })),
      SocialScreen(
          onChangedStep: (index) => setState(() {
                _indexSelected = index;
              })),
      AuthScreen(
          onChangedStep: (index) => setState(() {
                _indexSelected = index;
              })),
      Registration(
          onChangedStep: (index) => setState(() {
                _indexSelected = index;
              })),
      const Home(),
      const CGU(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.elementAt(_indexSelected),
    );
  }
}
