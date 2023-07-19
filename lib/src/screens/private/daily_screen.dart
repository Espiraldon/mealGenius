import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/models/content.dart';

import '../../data/data.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/mounth_state_widget.dart';
import '../../widget/reicipe.dart';
import '../../widget/today_state_widget.dart';
import '../../widget/week_month_widget.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  int _selectindex = 0;
  String _pagetitle = 'Today';
  static final List<Widget> _widgetOption = <Widget>[
    const Today(),
    const Week(),
    const Mounth()
  ];
  static final List<String> _pagetitles = <String>['Today', 'Week', 'Mounth'];
  void onItemTapped(int index) {
    setState(() {
      _selectindex = index;
      _pagetitle = _pagetitles[_selectindex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: CustomAppbar(
        title: _pagetitle,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => onItemTapped((_selectindex - 1) % 3),
        ),
        secondleading: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () => onItemTapped((_selectindex + 1) % 3),
        ),
      ),
      body: Center(
        child: Container(
          child: _widgetOption[_selectindex],
        ),
      ),
    );
  }
}

class meal extends StatelessWidget {
  final String title;
  const meal({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(
          title,
          style: GoogleFonts.lato(
              fontSize: 25, fontWeight: FontWeight.w500, color: tipo),
        ),
      ),
    );
  }
}
