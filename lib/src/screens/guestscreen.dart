import 'package:flutter/material.dart';
import 'package:happly/src/screens/public/Auth.dart';
import 'package:happly/src/screens/public/CGU.dart';
import 'package:happly/src/screens/public/registration.dart';
import 'package:happly/src/screens/private/question_screen.dart';

class GuestScreeen extends StatefulWidget {
  const GuestScreeen({super.key});

  @override
  State<GuestScreeen> createState() => _GuestScreeenState();
}

class _GuestScreeenState extends State<GuestScreeen> {
  List<Widget> _widgets = [];
  int _indexSelected = 0;
  @override
  void initState() {
    super.initState();
    _widgets.addAll([
      AuthScreen(
          onChangedStep: (index) => setState(() {
                _indexSelected = index;
              })),
      Registration(),
      CGU(),
      QuestionScreen(),
    ]);
  }

  Widget build(BuildContext context) {
    return Container(
      child: _widgets.elementAt(_indexSelected),
    );
  }
}
